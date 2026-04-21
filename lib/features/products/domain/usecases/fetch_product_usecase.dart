import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:clean_architecture_test/features/products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchProductUseCase
    implements UseCase<ProductEntity, FetchProductParams> {
  FetchProductUseCase(this.repository);

  final ProductsRepository repository;

  @override
  Future<Either<Failure, ProductEntity>> call(FetchProductParams params) async {
    return await repository.fetchProduct(id: params.id);
  }
}

class FetchProductParams {
  FetchProductParams({this.id});

  final String? id;
}
