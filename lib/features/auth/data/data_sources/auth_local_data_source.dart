import 'dart:convert';

import 'package:clean_architecture_test/features/auth/data/models/auth_token_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(AuthTokenModel token);

  Future<AuthTokenModel?> getCachedToken();

  Future<void> clearToken();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  static const String cachedToken = 'CACHED_TOKEN';

  @override
  Future<void> cacheToken(AuthTokenModel token) async {
    await sharedPreferences.setString(cachedToken, jsonEncode(token.toJson()));
  }

  @override
  Future<void> clearToken() async {
    await sharedPreferences.remove(cachedToken);
  }

  @override
  Future<AuthTokenModel?> getCachedToken() async {
    final jsonString = sharedPreferences.getString(cachedToken);
    if (jsonString != null) {
      return AuthTokenModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }
}
