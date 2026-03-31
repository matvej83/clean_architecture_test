import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/features/theme/data/data_sources/theme_local_data_source.dart';
import 'package:clean_architecture_test/features/theme/domain/entity/app_theme_mode.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/theme_repository.dart';

@LazySingleton(as: ThemeRepository)
class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource themeLocalDataSource;

  ThemeRepositoryImpl({required this.themeLocalDataSource});

  @override
  Either<Failure, AppThemeMode?> getTheme() {
    try {
      var mode = AppThemeMode.dark;
      final value = themeLocalDataSource.getTheme();
      switch (value) {
        case 'light':
          mode = AppThemeMode.light;
          break;
        case 'dark':
          mode = AppThemeMode.dark;
          break;
        default:
          mode = AppThemeMode.dark;
          break;
      }
      return Right(mode);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setTheme({required AppThemeMode mode}) async {
    try {
      await themeLocalDataSource.setTheme(mode.name);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
