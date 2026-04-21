import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entity/app_theme_mode.dart';
import '../repository/theme_repository.dart';

@lazySingleton
class SetThemeUseCase implements UseCase<void, SetThemeParams> {
  SetThemeUseCase(this.repository);

  final ThemeRepository repository;

  @override
  Future<Either<Failure, void>> call(SetThemeParams params) async {
    return await repository.setTheme(mode: params.mode);
  }
}

class SetThemeParams {
  SetThemeParams({required this.mode});

  final AppThemeMode mode;
}
