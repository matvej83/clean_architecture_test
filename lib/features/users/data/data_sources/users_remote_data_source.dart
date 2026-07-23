import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/network/base_remote_data_source.dart';

import '../../../auth/data/models/user_model.dart';

abstract class UsersRemoteDataSource {
  Future<List<UserModel>?> fetchUsers();

  Future<UserModel?> fetchUser({String? id});
}

@LazySingleton(as: UsersRemoteDataSource)
class UsersRemoteDataSourceImpl extends BaseRemoteDataSource
    implements UsersRemoteDataSource {
  UsersRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<UserModel>?> fetchUsers() async {
    return makeRequest<List<UserModel>?>(() async {
      final response = await dio.get(
        'users/',

        /// to use separated tread for data parsing
        options: Options(responseType: ResponseType.plain),
      );
      if (response.data != null) {
        final users = await compute(userModelFromList, response.data as String);
        return users;
      }
      return null;
    });
  }

  @override
  Future<UserModel?> fetchUser({String? id}) async {
    return makeRequest<UserModel?>(() async {
      final response = await dio.get('users/$id');
      if (response.data != null) {
        return UserModel.fromJson(response.data);
      }
      return null;
    });
  }
}
