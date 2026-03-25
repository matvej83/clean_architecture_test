import 'dart:convert';

import 'package:clean_architecture_test/features/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);

  Future<String?> getCachedToken();

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
  Future<void> cacheToken(String token) async {
    await sharedPreferences.setString(cachedToken, token);
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
  Future<String?> getCachedToken() async {
    return sharedPreferences.getString(cachedToken);
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
