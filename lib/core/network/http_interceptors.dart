import 'dart:async';

import 'package:clean_architecture_test/features/auth/data/models/auth_token_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/data/data_sources/auth_local_data_source.dart';
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
    final isRefreshCall = err.requestOptions.path.contains(
      'auth/refresh-token',
    );

    if (isUnauthorized && !isRefreshCall) {
      final completer = Completer<Response>();

      _queue.add((request: err.requestOptions, completer: completer));

      if (!_isRefreshing) {
        _isRefreshing = true;

        try {
          final token = await localDataSource.getCachedToken();

          /// logout
          if (token?.refreshToken == null) {
            sessionManager.logout();
            throw Exception('No refresh token');
          }

          final response = await refreshDio.post(
            'auth/refresh-token',
            data: {'refreshToken': token!.refreshToken},
            options: Options(extra: {'skipAuth': true}),
          );

          final newAccessToken = response.data['accessToken'];
          final newRefreshToken = response.data['refreshToken'];

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

      final response = await completer.future;
      return handler.resolve(response);
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
    String message = 'Unexpected error';

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout';
        break;
      default:
        if (err.response != null) {
          final statusCode = err.response!.statusCode;

          switch (statusCode) {
            case 400:
              message = 'Bad request';
              break;
            case 401:
              message = 'Unauthorized';
              break;
            case 403:
              message = 'Forbidden';
              break;
            case 404:
              message = 'Not found';
              break;
            case 500:
              message = 'Server error';
              break;
          }
        }
    }

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
