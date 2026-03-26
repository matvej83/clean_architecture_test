import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> fetchProducts();

  Future<Either<Failure, List<CategoryEntity>>> fetchCategories();
}
