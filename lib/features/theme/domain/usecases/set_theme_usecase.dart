import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entity/app_theme_mode.dart';
import '../repository/theme_repository.dart';

@lazySingleton
class SetThemeUseCase implements UseCase<void, SetThemeParams> {
  final ThemeRepository repository;

  SetThemeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SetThemeParams params) async {
    return await repository.setTheme(mode: params.mode);
  }
}

class SetThemeParams {
  final AppThemeMode mode;

  SetThemeParams({required this.mode});
}
