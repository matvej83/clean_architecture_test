import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/data/data_sources/auth_local_data_source.dart';

@lazySingleton
class AuthSessionManager {
  final AuthLocalDataSource localDataSource;

  VoidCallback? onLogout;

  AuthSessionManager(this.localDataSource);

  Future<void> logout() async {
    await localDataSource.clearToken();
    onLogout?.call();
  }
}
