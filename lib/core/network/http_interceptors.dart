import 'dart:async';

import 'package:clean_architecture_test/features/auth/data/models/auth_token_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/data/data_sources/auth_local_data_source.dart';
import '../error/exception.dart';
import '../services/auth_session_manager.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource localDataSource;
  final AuthSessionManager sessionManager;
  final Dio refreshDio;

  AuthInterceptor(
    this.localDataSource,
    this.sessionManager,
    @Named('refresh_dio') this.refreshDio,
  );

  bool _isRefreshing = false;

  final List<({RequestOptions request, Completer<Response> completer})> _queue =
      [];

  // ========================
  // REQUEST
  // ========================
  @override
  void onRequest(
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

  // ========================
  // ERROR (401 HANDLING)
  // ========================
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final isUnauthorized = err.response?.statusCode == 401;
    final skipLoginError = err.requestOptions.path.contains('auth/login');
    final isRefreshCall = err.requestOptions.path.contains(
      'auth/refresh-token',
    );

    if (isUnauthorized && !isRefreshCall && !skipLoginError) {
      final completer = Completer<Response>();

      _queue.add((request: err.requestOptions, completer: completer));

      if (!_isRefreshing) {
        _isRefreshing = true;

        try {
          final token = await localDataSource.getCachedToken();

          /// logout
          if (token?.refreshToken == null) {
            sessionManager.logout();
            throw InvalidCredentialsException();
          }

          final response = await refreshDio.post(
            'auth/refresh-token',
            data: {'refreshToken': token!.refreshToken},
            options: Options(extra: {'skipAuth': true}),
          );

          final newAccessToken = response.data['access_token'];
          final newRefreshToken = response.data['refresh_token'];

          await localDataSource.cacheToken(
            AuthTokenModel(
              accessToken: newAccessToken,
              refreshToken: newRefreshToken,
            ),
          );

          /// Retry all the requests
          for (final item in _queue) {
            try {
              final newRequest = item.request.copyWith(
                headers: {
                  ...item.request.headers,
                  'Authorization': 'Bearer $newAccessToken',
                },
              );

              final response = await refreshDio.fetch(newRequest);
              item.completer.complete(response);
            } catch (e) {
              item.completer.completeError(e);
            }
          }
        } catch (e) {
          // logout
          sessionManager.logout();

          for (final item in _queue) {
            item.completer.completeError(e);
          }
        } finally {
          _queue.clear();
          _isRefreshing = false;
        }
      }

      try {
        final response = await completer.future;
        return handler.resolve(response);
      } catch (e) {
        return handler.reject(
          e is DioException
              ? e
              : DioException(requestOptions: err.requestOptions, error: e),
        );
      }
    }

    handler.next(err);
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
      DioExceptionType.sendTimeout => 'Receive timeout',
      DioExceptionType.receiveTimeout => 'Receive timeout',
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

    final newError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: err.error ?? message,
      message: message,
    );

    handler.next(newError);
  }
}
