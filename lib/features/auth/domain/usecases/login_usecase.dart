import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/auth/domain/entity/auth_token_entity.dart';
import 'package:clean_architecture_test/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginUseCase implements UseCase<AuthTokenEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthTokenEntity>> call(params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
