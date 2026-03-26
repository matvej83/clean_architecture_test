import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/domain/entity/user_entity.dart';
import '../repository/users_repository.dart';

@lazySingleton
class FetchUsersUseCase implements UseCase<List<UserEntity>, NoParams> {
  final UsersRepository repository;

  FetchUsersUseCase(this.repository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return await repository.fetchUsers();
  }
}
