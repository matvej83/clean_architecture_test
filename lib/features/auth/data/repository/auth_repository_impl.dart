import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/error/mapper.dart';
import 'package:clean_architecture_test/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:clean_architecture_test/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:clean_architecture_test/features/auth/data/models/auth_token_model.dart';
import 'package:clean_architecture_test/features/auth/data/models/user_model.dart';
import 'package:clean_architecture_test/features/auth/domain/entity/auth_token_entity.dart';
import 'package:clean_architecture_test/features/auth/domain/entity/user_entity.dart';
import 'package:clean_architecture_test/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({
    required this.authLocalDataSource,
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await authLocalDataSource.getCachedToken();
      return Right(token != null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, AuthTokenEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final token = await authRemoteDataSource.login(email, password);
      await authLocalDataSource.cacheToken(
        AuthTokenModel(accessToken: '', refreshToken: ''),
      );
      await authLocalDataSource.cacheToken(token!);
      return Right(token.toEntity());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authRemoteDataSource.logout();
      await authLocalDataSource.clearToken();
      return Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getUserProfile() async {
    try {
      final user = await authRemoteDataSource.getUserProfile();
      return Right(user?.toEntity());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
