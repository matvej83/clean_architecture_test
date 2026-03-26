import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/error/mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../domain/repository/users_repository.dart';
import '../data_sources/users_remote_data_source.dart';

@LazySingleton(as: UsersRepository)
class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource productsRemoteDataSource;

  UsersRepositoryImpl({required this.productsRemoteDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> fetchUsers() async {
    try {
      final products = await productsRemoteDataSource.fetchUsers();
      final list = products?.map((e) => e.toEntity()).toList() ?? [];
      return Right(list);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> fetchUser({String? id}) async {
    try {
      final product = await productsRemoteDataSource.fetchUser(id: id);
      return Right(product!.toEntity());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
