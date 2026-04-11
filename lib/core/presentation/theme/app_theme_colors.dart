import 'package:flutter/material.dart';

abstract class AppThemeColors {
  Color get scaffoldBackground;

  Color get unselectedWidget;

  Color get canvas;

  Color get splash;

  Color get surfaceTint;

  Color get bottomBarBackground;

  Color get fieldBorder;

  Color get fieldBorderFocussed;

  Color get fieldBorderDisabled;

  Color get primaryText;

  Color get secondaryText;
}

class DarkThemeColors implements AppThemeColors {
  @override
  Color get bottomBarBackground => Color(0xFF222222);

  @override
  Color get canvas => Colors.black;

  @override
  Color get fieldBorder => Colors.grey;

  @override
  Color get fieldBorderDisabled => Colors.blueGrey;

  @override
  Color get fieldBorderFocussed => Colors.blue;

  @override
  Color get primaryText => Colors.white;

  @override
  Color get scaffoldBackground => Colors.black;

  @override
  Color get secondaryText => Colors.grey.shade600;

  @override
  Color get splash => Colors.black;

  @override
  Color get surfaceTint => Colors.transparent;

  @override
  Color get unselectedWidget => Colors.grey.shade400;
}

class LightThemeColors implements AppThemeColors {
  @override
  Color get bottomBarBackground => Colors.grey;

  @override
  Color get canvas => Colors.white;

  @override
  Color get fieldBorder => Colors.grey;

  @override
  Color get fieldBorderDisabled => Colors.blueGrey;

  @override
  Color get fieldBorderFocussed => Colors.blue;

  @override
  Color get primaryText => Colors.black;

  @override
  Color get scaffoldBackground => Colors.white;

  @override
  Color get secondaryText => Colors.grey.shade600;

  @override
  Color get splash => Colors.white;

  @override
  Color get surfaceTint => Colors.transparent;

  @override
  Color get unselectedWidget => Colors.grey.shade400;
}
