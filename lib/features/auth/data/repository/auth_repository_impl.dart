import 'package:clean_architecture_test/core/error/exception.dart';
import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:clean_architecture_test/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:clean_architecture_test/features/auth/data/models/user_model.dart';
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
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await authLocalDataSource.getCachedUser();
      return Right(user?.toEntity());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

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
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDataSource.login(email, password);
      await authLocalDataSource.cacheToken('mock_token_${user?.id}');
      await authLocalDataSource.cacheUser(user!);
      return Right(user.toEntity());
    } on InvalidCredentialsException {
      return Left(InvalidCredentialsFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authRemoteDataSource.logout();
      await authLocalDataSource.clearToken();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
