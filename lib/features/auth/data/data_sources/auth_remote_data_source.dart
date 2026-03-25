import 'package:clean_architecture_test/core/error/exception.dart';
import 'package:clean_architecture_test/features/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> login(String email, String password);

  Future<void> logout();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@test.com' && password == '12345') {
      return UserModel(id: '1', email: 'test@test.com', name: 'Test user');
    } else {
      throw InvalidCredentialsException();
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
