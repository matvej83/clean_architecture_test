import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/theme/domain/repository/theme_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entity/app_theme_mode.dart';

@lazySingleton
class GetThemeUseCase implements UseCase<AppThemeMode?, NoParams> {
  GetThemeUseCase(this.repository);

  final ThemeRepository repository;

  @override
  Future<Either<Failure, AppThemeMode?>> call(NoParams params) async {
    return repository.getTheme();
  }
}
