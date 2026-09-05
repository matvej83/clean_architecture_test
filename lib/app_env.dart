import 'package:flutter/material.dart';

import 'core/constants/app_strings.dart';

@immutable
class AppEnv {
  const AppEnv._();

  static String get baseUrl => const String.fromEnvironment(
    'BASE_URL',
    defaultValue: AppStrings.baseUrl,
  );
}
