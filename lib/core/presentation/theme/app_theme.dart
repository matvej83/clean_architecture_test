import 'package:flutter/material.dart';

import 'app_semantic_colors.dart';
import 'app_theme_colors.dart';

class AppTheme {
  static ThemeData dark(
    AppThemeColors appColors,
  ) => ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: appColors.scaffoldBackground,
    unselectedWidgetColor: appColors.unselectedWidget,
    canvasColor: appColors.canvas,
    splashColor: appColors.splash,
    extensions: [AppSemanticColors(success: appColors.success)],
    colorScheme: ColorScheme.dark().copyWith(
      brightness: Brightness.dark,
      primary: appColors.primary,
      onPrimary: appColors.onPrimary,
      surfaceTint: appColors.surfaceTint,
      error: appColors.error,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      surfaceTintColor: appColors.surfaceTint,
      scrolledUnderElevation: 0.0,
      backgroundColor: appColors.bottomBarBackground,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: appColors.bottomBarBackground,
      selectedItemColor: appColors.primaryText,
      showSelectedLabels: true,
      showUnselectedLabels: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: appColors.fieldBorder, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: appColors.fieldBorder, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(
          color: appColors.fieldBorderFocussed,
          width: 2.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(
          color: appColors.fieldBorderDisabled,
          width: 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: appColors.error, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: appColors.error, width: 2.0),
      ),
      errorStyle: TextStyle(color: appColors.error),
      labelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return TextStyle(color: appColors.error);
        }
        return TextStyle();
      }),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return TextStyle(color: appColors.error);
        }
        if (states.contains(WidgetState.focused)) {
          return TextStyle(color: appColors.primary);
        }
        return TextStyle(color: appColors.unselectedWidget);
      }),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: appColors.onPrimary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: appColors.onPrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: appColors.primary),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        prefixIconConstraints: BoxConstraints(maxHeight: 24.0),
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(appColors.scaffoldBackground),
        surfaceTintColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return appColors.unselectedWidget;
          }
          return appColors.surfaceTint;
        }),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: appColors.primary,
        disabledBackgroundColor: appColors.unselectedWidget,
        foregroundColor: appColors.onPrimary,
        disabledForegroundColor: appColors.fieldBorderDisabled,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: const CircleBorder(),
      backgroundColor: appColors.primary,
      foregroundColor: appColors.onPrimary,
      enableFeedback: true,
      elevation: 2,
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStateProperty.all(appColors.unselectedWidget),
      shadowColor: WidgetStateProperty.all(appColors.surfaceTint),
      elevation: WidgetStateProperty.all(0),
      surfaceTintColor: WidgetStateProperty.all(appColors.surfaceTint),
      shape: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: appColors.fieldBorderFocussed),
          );
        }
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        );
      }),
    ),
  );

  static ThemeData light(
    AppThemeColors appColors,
  ) => ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: appColors.scaffoldBackground,
    canvasColor: appColors.canvas,
    splashColor: appColors.splash,
    unselectedWidgetColor: appColors.unselectedWidget,
    extensions: [AppSemanticColors(success: appColors.success)],
    colorScheme: ColorScheme.light().copyWith(
      brightness: Brightness.light,
      primary: appColors.primary,
      onPrimary: appColors.onPrimary,
      surfaceTint: appColors.surfaceTint,
      error: appColors.error,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      surfaceTintColor: appColors.surfaceTint,
      scrolledUnderElevation: 0.0,
      backgroundColor: appColors.bottomBarBackground,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: appColors.bottomBarBackground,
      selectedItemColor: appColors.primaryText,
      showSelectedLabels: true,
      showUnselectedLabels: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: appColors.fieldBorder, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: appColors.fieldBorder, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(
          color: appColors.fieldBorderFocussed,
          width: 2.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(
          color: appColors.fieldBorderDisabled,
          width: 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: appColors.error, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: appColors.error, width: 2.0),
      ),
      errorStyle: TextStyle(color: appColors.error),
      labelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return TextStyle(color: appColors.error);
        }
        return TextStyle();
      }),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return TextStyle(color: appColors.error);
        }
        if (states.contains(WidgetState.focused)) {
          return TextStyle(color: appColors.primary);
        }
        return const TextStyle(color: Colors.grey);
      }),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: appColors.fieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: appColors.fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: appColors.fieldBorderFocussed),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        prefixIconConstraints: BoxConstraints(maxHeight: 24.0),
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(appColors.scaffoldBackground),
        surfaceTintColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return appColors.fieldBorder;
          }
          return appColors.surfaceTint;
        }),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: appColors.primary,
        disabledBackgroundColor: appColors.unselectedWidget,
        foregroundColor: appColors.onPrimary,
        disabledForegroundColor: appColors.fieldBorderDisabled,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: const CircleBorder(),
      backgroundColor: appColors.primary,
      foregroundColor: appColors.onPrimary,
      enableFeedback: true,
      elevation: 2,
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStateProperty.all(appColors.unselectedWidget),
      shadowColor: WidgetStateProperty.all(appColors.surfaceTint),
      elevation: WidgetStateProperty.all(0),
      surfaceTintColor: WidgetStateProperty.all(appColors.surfaceTint),
      shape: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: appColors.primary),
          );
        }
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        );
      }),
    ),
  );
}
