import 'exception.dart';
import 'failure.dart';

Failure mapExceptionToFailure(Object error) {
  if (error is UnauthorizedException) return UnauthorizedFailure();
  if (error is InvalidCredentialsException) {
    return InvalidCredentialsFailure();
  }
  if (error is ServerException) return ServerFailure(message: error.message);
  if (error is TimeoutException) return TimeoutFailure();
  if (error is NoInternetException) return NoInternetFailure();
  if (error is CacheException) return CacheFailure();

  if (error is UnknownException) {
    return UnknownFailure(error.message);
  }

  return UnknownFailure(error.toString());
}
