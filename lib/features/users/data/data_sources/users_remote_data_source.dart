import 'package:clean_architecture_test/core/error/exception.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/data/models/user_model.dart';

abstract class UsersRemoteDataSource {
  Future<List<UserModel>?> fetchUsers();

  Future<UserModel?> fetchUser({String? id});
}

@LazySingleton(as: UsersRemoteDataSource)
class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  UsersRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<UserModel>?> fetchUsers() async {
    try {
      final response = await dio.get('users/');
      if (response.data != null) {
        return UserModel.fromList(response.data);
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

  @override
  Future<UserModel?> fetchUser({String? id}) async {
    try {
      final response = await dio.get('users/$id');
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
