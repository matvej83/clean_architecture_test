/// App exception
abstract class AppException implements Exception {}

/// Network Exceptions
abstract class NetworkException extends AppException {}

class UnauthorizedException extends NetworkException {}

class ServerException extends NetworkException {}

class TimeoutException extends NetworkException {}

class NoInternetException extends NetworkException {}

class UnknownException extends NetworkException {
  final String message;

  UnknownException(this.message);
}

/// CacheException
class CacheException extends AppException {}

/// Auth exceptions
class InvalidCredentialsException extends AppException {}
