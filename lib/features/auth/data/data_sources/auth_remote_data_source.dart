import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/network/base_remote_data_source.dart';
import 'package:store_app/features/auth/data/models/auth_token_model.dart';
import 'package:store_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthTokenModel?> login(String email, String password);

  Future<UserModel?> getUserProfile();

  Future<void> logout();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends BaseRemoteDataSource
    implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<AuthTokenModel?> login(String email, String password) async {
    return makeRequest<AuthTokenModel?>(() async {
      final response = await dio.post(
        'auth/login',
        queryParameters: {'email': email, 'password': password},
        options: Options(extra: {'skipAuth': true}),
      );
      if (response.data != null) {
        return AuthTokenModel.fromJson(response.data);
      }
      return null;
    });
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<UserModel?> getUserProfile() async {
    return makeRequest<UserModel?>(() async {
      final response = await dio.get('auth/profile');
      if (response.data != null) {
        return UserModel.fromJson(response.data);
      }
      return null;
    });
  }
}
