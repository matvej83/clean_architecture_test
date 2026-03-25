import 'dart:convert';

import 'package:clean_architecture_test/features/auth/data/models/auth_token_model.dart';
import 'package:clean_architecture_test/features/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(AuthTokenModel token);

  Future<AuthTokenModel?> getCachedToken();

  Future<void> clearToken();

  Future<void> cacheUser(UserModel user);

  Future<UserModel?> getCachedUser();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  static const String cachedToken = 'CACHED_TOKEN';
  static const String cachedUser = 'CACHED_USER';

  @override
  Future<void> cacheToken(AuthTokenModel token) async {
    await sharedPreferences.setString(cachedToken, jsonEncode(token.toJson()));
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString(cachedUser, jsonEncode(user.toJson()));
  }

  @override
  Future<void> clearToken() async {
    await sharedPreferences.remove(cachedToken);
    await sharedPreferences.remove(cachedUser);
  }

  @override
  Future<AuthTokenModel?> getCachedToken() async {
    final jsonString = sharedPreferences.getString(cachedToken);
    if (jsonString != null) {
      return AuthTokenModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = sharedPreferences.getString(cachedUser);
    if (jsonString != null) {
      return UserModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }
}
