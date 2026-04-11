import 'package:clean_architecture_test/core/presentation/theme/app_theme.dart';
import 'package:clean_architecture_test/core/presentation/theme/app_theme_colors.dart';
import 'package:clean_architecture_test/features/theme/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../domain/entity/app_theme_mode.dart';
import '../domain/usecases/get_theme_usecase.dart';
import '../domain/usecases/set_theme_usecase.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeState> {
  final GetThemeUseCase getThemeUseCase;
  final SetThemeUseCase setThemeUseCase;

  ThemeCubit({required this.getThemeUseCase, required this.setThemeUseCase})
    : super(ThemeState());

  Future<void> loadTheme() async {
    final mode = getThemeUseCase.repository.getTheme();
    mode.fold(
      (l) {
        emit(
          state.copyWith(
            mode: AppThemeMode.dark,
            theme: AppTheme.dark(DarkThemeColors()),
          ),
        );
      },
      (r) {
        if (r != null) {
          emit(state.copyWith(theme: _mapToFlutter(r), mode: r));
        } else {
          emit(
            state.copyWith(
              mode: AppThemeMode.dark,
              theme: AppTheme.dark(DarkThemeColors()),
            ),
          );
        }
      },
    );
  }

  Future<void> changeTheme(AppThemeMode mode) async {
    await setThemeUseCase.repository.setTheme(mode: mode);
    emit(state.copyWith(theme: _mapToFlutter(mode), mode: mode));
  }

  ThemeData _mapToFlutter(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return AppTheme.light(LightThemeColors());
      case AppThemeMode.dark:
        return AppTheme.dark(DarkThemeColors());
    }
  }
}
