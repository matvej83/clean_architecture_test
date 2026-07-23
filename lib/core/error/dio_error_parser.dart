import 'package:dio/dio.dart';

import 'exception.dart';

class ApiErrorHandler {
  static Exception onDioError(DioException e) {
    final statusCode = e.response?.statusCode;
    final serverMessage = e.response?.data?['error']?['message']?.toString();

    switch (statusCode) {
      case 400:
        return UnknownException(message: serverMessage ?? 'Bad Request');
      case 401:
        return InvalidCredentialsException();
      default:
        return UnknownException(
          message: serverMessage ?? e.message ?? 'Network error',
        );
    }
  }

  static Exception onError(Object e) {
    if (e is DioException) {
      return onDioError(e);
    } else {
      return UnknownException(message: e.toString());
    }
  }
}
