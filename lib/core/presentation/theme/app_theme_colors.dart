import 'package:flutter/material.dart';

class AppThemeColors {
  const AppThemeColors({
    required this.primary,
    required this.onPrimary,
    required this.error,
    required this.onError,
    required this.success,
    required this.scaffoldBackground,
    required this.unselectedWidget,
    required this.canvas,
    required this.splash,
    required this.surfaceTint,
    required this.bottomBarBackground,
    required this.fieldBorder,
    required this.fieldBorderFocussed,
    required this.fieldBorderDisabled,
    required this.primaryText,
    required this.secondaryText,
  });

  final Color primary;
  final Color onPrimary;
  final Color error;
  final Color onError;
  final Color success;
  final Color scaffoldBackground;
  final Color unselectedWidget;
  final Color canvas;
  final Color splash;
  final Color surfaceTint;
  final Color bottomBarBackground;
  final Color fieldBorder;
  final Color fieldBorderFocussed;
  final Color fieldBorderDisabled;
  final Color primaryText;
  final Color secondaryText;
}

class AppColorSchemes {
  static final dark = AppThemeColors(
    primary: Colors.blue,
    onPrimary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    success: Colors.green,
    scaffoldBackground: Colors.black,
    unselectedWidget: Colors.grey.shade400,
    canvas: Colors.black,
    splash: Colors.black,
    surfaceTint: Colors.transparent,
    bottomBarBackground: Color(0xFF222222),
    fieldBorder: Colors.grey,
    fieldBorderFocussed: Colors.blue,
    fieldBorderDisabled: Colors.blueGrey,
    primaryText: Colors.black,
    secondaryText: Colors.grey.shade600,
  );

  static final light = AppThemeColors(
    primary: Colors.blue,
    onPrimary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    success: Colors.green,
    scaffoldBackground: Colors.white,
    unselectedWidget: Colors.grey.shade400,
    canvas: Colors.white,
    splash: Colors.white,
    surfaceTint: Colors.transparent,
    bottomBarBackground: Colors.grey,
    fieldBorder: Colors.grey,
    fieldBorderFocussed: Colors.blue,
    fieldBorderDisabled: Colors.blueGrey,
    primaryText: Colors.black,
    secondaryText: Colors.grey.shade600,
  );
}
