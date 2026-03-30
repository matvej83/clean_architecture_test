import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../features/auth/domain/repository/auth_repository.dart';

@lazySingleton
class AuthSessionManager {
  AuthRepository? _authRepository;

  final _controller = StreamController<void>.broadcast();

  Stream<void> get onSessionExpired => _controller.stream;

  void setRepository(AuthRepository repo) => _authRepository = repo;

  void notifySessionExpired() => _controller.add(null);

  Future<void> logout() async {
    try {
      await _authRepository?.logout();
    } catch (_) {}
  }
}
