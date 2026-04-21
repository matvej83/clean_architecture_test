import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/auth/domain/entity/user_entity.dart';
import 'package:clean_architecture_test/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserProfileUseCase implements UseCase<UserEntity?, NoParams> {
  GetUserProfileUseCase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await repository.getUserProfile();
  }
}
