/// App exception
abstract class AppException implements Exception {}

/// Network Exceptions
abstract class NetworkException extends AppException {}

class UnauthorizedException extends NetworkException {}

class ServerException extends NetworkException {
  ServerException({this.message});

  final String? message;
}

class TimeoutException extends NetworkException {}

class NoInternetException extends NetworkException {}

class UnknownException extends NetworkException {
  UnknownException(this.message);

  final String message;
}

/// CacheException
class CacheException extends AppException {}

/// Auth exceptions
class InvalidCredentialsException extends AppException {}
