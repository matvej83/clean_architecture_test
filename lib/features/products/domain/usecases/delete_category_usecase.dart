import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteCategoryUseCase implements UseCase<bool, DeleteCategoryParams> {
  final ProductsRepository repository;

  DeleteCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeleteCategoryParams params) async {
    return await repository.deleteCategory(id: params.id);
  }
}

class DeleteCategoryParams {
  final int id;

  DeleteCategoryParams({required this.id});
}
