import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../auth/domain/entity/user_entity.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<UserEntity>>> fetchUsers();

  Future<Either<Failure, UserEntity>> fetchUser({String? id});
}
