import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteProductUseCase implements UseCase<bool, DeleteProductParams> {
  DeleteProductUseCase(this.repository);

  final ProductsRepository repository;

  @override
  Future<Either<Failure, bool>> call(DeleteProductParams params) async {
    return await repository.deleteProduct(id: params.id);
  }
}

class DeleteProductParams {
  DeleteProductParams({required this.id});

  final int id;
}
