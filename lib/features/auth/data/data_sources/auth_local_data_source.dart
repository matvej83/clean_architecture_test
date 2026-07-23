import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/features/auth/data/models/auth_token_model.dart';

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

  AuthTokenModel? _tokenModel;

  @override
  Future<void> cacheToken(AuthTokenModel token) async {
    _tokenModel = token;
    await sharedPreferences.setString(cachedToken, jsonEncode(token.toJson()));
  }

  @override
  Future<void> clearToken() async {
    _tokenModel = null;
    await sharedPreferences.remove(cachedToken);
  }

  @override
  Future<AuthTokenModel?> getCachedToken() async {
    if (_tokenModel != null) {
      return _tokenModel;
    }
    final jsonString = sharedPreferences.getString(cachedToken);
    if (jsonString != null) {
      _tokenModel = AuthTokenModel.fromJson(jsonDecode(jsonString));
      return _tokenModel;
    }
    return null;
  }
}
