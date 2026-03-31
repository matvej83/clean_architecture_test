import 'package:flutter/material.dart';

import '../domain/entity/app_theme_mode.dart';

class ThemeState {
  final ThemeData? theme;
  final AppThemeMode mode;

  const ThemeState({this.theme, this.mode = AppThemeMode.dark});

  ThemeState copyWith({ThemeData? theme, AppThemeMode? mode}) {
    return ThemeState(theme: theme ?? this.theme, mode: mode ?? this.mode);
  }
}
