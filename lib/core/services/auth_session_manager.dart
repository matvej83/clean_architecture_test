import 'dart:async';

import 'package:injectable/injectable.dart';

@lazySingleton
class AuthSessionManager {
  final _controller = StreamController<void>.broadcast();

  Stream<void> get onSessionExpired => _controller.stream;

  void notifySessionExpired() => _controller.add(null);
}
