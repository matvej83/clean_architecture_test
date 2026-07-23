import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/features/auth/data/models/auth_token_model.dart';

import '../../features/auth/data/data_sources/auth_local_data_source.dart';
import '../error/exception.dart';
import '../services/auth_session_manager.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  AuthInterceptor(
    this.localDataSource,
    this.sessionManager,
    @Named('refresh_dio') this.refreshDio,
  );

  static const _loginPath = 'auth/login';
  static const _refreshPath = 'auth/refresh-token';

  final AuthLocalDataSource localDataSource;
  final AuthSessionManager sessionManager;
  final Dio refreshDio;

  Future<void>? _refreshFuture;

  final List<({RequestOptions request, Completer<Response> completer})> _queue =
      [];

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final skipAuth = options.extra['skipAuth'] == true;

    if (!skipAuth) {
      final token = await localDataSource.getCachedToken();

      if (token?.accessToken != null) {
        options.headers['Authorization'] = 'Bearer ${token!.accessToken}';
      }
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;

    final isUnauthorized = statusCode == 401;

    final isLoginCall = err.requestOptions.path.endsWith(_loginPath);

    final isRefreshCall = err.requestOptions.path.endsWith(_refreshPath);

    final alreadyRetried = err.requestOptions.extra['retried'] == true;

    /// Refresh token expired or invalid
    if (isUnauthorized && isRefreshCall) {
      sessionManager.notifySessionExpired();

      return handler.reject(err);
    }

    /// Regular 401 handling
    if (isUnauthorized && !isLoginCall && !isRefreshCall && !alreadyRetried) {
      final completer = Completer<Response>();

      _queue.add((request: err.requestOptions, completer: completer));

      try {
        _refreshFuture ??= _performRefresh();

        await _refreshFuture;

        final response = await completer.future;

        return handler.resolve(response);
      } catch (e) {
        if (e is DioException) {
          return handler.reject(e);
        }

        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            response: err.response,
            error: e,
          ),
        );
      }
    }

    handler.next(err);
  }

  Future<void> _performRefresh() async {
    try {
      final newAccessToken = await _refreshToken();

      while (_queue.isNotEmpty) {
        final item = _queue.removeAt(0);

        try {
          final request = item.request.copyWith(
            headers: {
              ...item.request.headers,
              'Authorization': 'Bearer $newAccessToken',
            },
            extra: {...item.request.extra, 'retried': true},
          );

          final response = await refreshDio.fetch(request);

          item.completer.complete(response);
        } catch (e) {
          item.completer.completeError(
            e is DioException
                ? e
                : DioException(requestOptions: item.request, error: e),
          );
        }
      }
    } catch (e) {
      final isUnauthorized = e is DioException && e.response?.statusCode == 401;

      if (isUnauthorized || e is InvalidCredentialsException) {
        sessionManager.notifySessionExpired();
      }

      while (_queue.isNotEmpty) {
        final item = _queue.removeAt(0);

        item.completer.completeError(
          e is DioException
              ? e
              : DioException(requestOptions: item.request, error: e),
        );
      }
      return;
    } finally {
      _refreshFuture = null;
    }
  }

  Future<String> _refreshToken() async {
    final token = await localDataSource.getCachedToken();

    if (token?.refreshToken == null) {
      throw InvalidCredentialsException();
    }

    final response = await refreshDio.post(
      _refreshPath,
      data: {'refreshToken': token!.refreshToken},
      options: Options(extra: {'skipAuth': true}),
    );

    final accessToken = response.data['access_token'] as String;
    final refreshToken = response.data['refresh_token'] as String;

    await localDataSource.cacheToken(
      AuthTokenModel(accessToken: accessToken, refreshToken: refreshToken),
    );

    return accessToken;
  }
}

// ========================
// ERROR INTERCEPTOR
// ========================

@lazySingleton
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message = switch (err.type) {
      DioExceptionType.connectionTimeout => 'Connection timeout',
      DioExceptionType.sendTimeout => 'Send timeout',
      DioExceptionType.receiveTimeout => 'Receive timeout',
      DioExceptionType.cancel => 'Request cancelled',
      _ =>
        err.response != null
            ? switch (err.response!.statusCode) {
                400 => 'Bad request',
                401 => 'Unauthorized',
                403 => 'Forbidden',
                404 => 'Not found',
                500 => 'Server error',
                _ => 'Unexpected error',
              }
            : 'Unexpected error',
    };

    handler.next(err.copyWith(message: message));
  }
}
