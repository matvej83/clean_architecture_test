import 'package:flutter/material.dart';

@immutable
class AppEnv {
  const AppEnv._();

  static String get baseUrl => const String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.escuelajs.co/api/v1/',
  );
}
