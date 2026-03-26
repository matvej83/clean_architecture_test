import 'package:clean_architecture_test/core/error/exception.dart';
import 'package:clean_architecture_test/features/auth/data/models/auth_token_model.dart';
import 'package:clean_architecture_test/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<AuthTokenModel?> login(String email, String password);

  Future<UserModel?> getUserProfile();

  Future<void> logout();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthTokenModel?> login(String email, String password) async {
    final response = await dio.post(
      'auth/login',
      queryParameters: {'email': email, 'password': password},
      options: Options(extra: {'skipAuth': true}),
    );
    if (response.data != null) {
      return AuthTokenModel.fromJson(response.data);
    } else {
      throw InvalidCredentialsException();
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<UserModel?> getUserProfile() async {
    try {
      final response = await dio.get('auth/profile');
      if (response.data != null) {
        return UserModel.fromJson(response.data);
      }
    } on Exception catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        throw InvalidCredentialsException();
      } else {
        throw ServerException();
      }
    }
    return null;
  }
}
