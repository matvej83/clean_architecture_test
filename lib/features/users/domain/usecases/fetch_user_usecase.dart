import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/domain/entity/user_entity.dart';
import '../repository/users_repository.dart';

@lazySingleton
class FetchUserUseCase implements UseCase<UserEntity, FetchUserParams> {
  final UsersRepository repository;

  FetchUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(FetchUserParams params) async {
    return await repository.fetchUser(id: params.id);
  }
}

class FetchUserParams {
  final String? id;

  FetchUserParams({this.id});
}
