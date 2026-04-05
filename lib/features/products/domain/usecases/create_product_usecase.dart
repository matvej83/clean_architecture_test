import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/products/data/models/product_model.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:clean_architecture_test/features/products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateProductUseCase
    implements UseCase<ProductEntity, CreateProductParams> {
  final ProductsRepository repository;

  CreateProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(CreateProductParams params) async {
    return await repository.createProduct(product: params.product);
  }
}

class CreateProductParams {
  final ProductModel product;

  CreateProductParams({required this.product});
}
