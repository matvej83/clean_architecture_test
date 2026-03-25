import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class InvalidCredentialsFailure extends Failure {}

class UnauthorizedFailure extends Failure {}

class TimeoutFailure extends Failure {}

class NoInternetFailure extends Failure {}

class UnknownFailure extends Failure {
  final String message;

  UnknownFailure(this.message);
}
