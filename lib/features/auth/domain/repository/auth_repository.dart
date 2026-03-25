import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/features/auth/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../entity/auth_token_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthTokenEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity?>> getCurrentUser();

  Future<Either<Failure, UserEntity?>> getUserProfile();

  Future<Either<Failure, bool>> isAuthenticated();
}
