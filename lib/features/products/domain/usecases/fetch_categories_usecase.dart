import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:clean_architecture_test/features/products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchCategoriesUseCase
    implements UseCase<List<CategoryEntity>, NoParams> {
  final ProductsRepository repository;

  FetchCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async {
    return await repository.fetchCategories();
  }
}
