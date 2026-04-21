import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/domain/entity/user_entity.dart';
import '../repository/users_repository.dart';

@lazySingleton
class FetchUserUseCase implements UseCase<UserEntity, FetchUserParams> {
  FetchUserUseCase(this.repository);

  final UsersRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(FetchUserParams params) async {
    return await repository.fetchUser(id: params.id);
  }
}

class FetchUserParams {
  FetchUserParams({this.id});

  final String? id;
}
