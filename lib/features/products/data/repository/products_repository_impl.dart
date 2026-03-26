import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/error/mapper.dart';
import 'package:clean_architecture_test/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:clean_architecture_test/features/products/data/models/product_model.dart';
import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:clean_architecture_test/features/products/domain/repository/products_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../models/category_model.dart';

@LazySingleton(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImpl({required this.productsRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> fetchProducts({
    String? categoryId,
  }) async {
    try {
      final products = await productsRemoteDataSource.fetchProducts(
        categoryId: categoryId,
      );
      final list = products?.map((e) => e.toEntity()).toList() ?? [];
      return Right(list);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> fetchProduct({String? id}) async {
    try {
      final product = await productsRemoteDataSource.fetchProduct(id: id);
      return Right(product!.toEntity());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> fetchCategories() async {
    try {
      final categories = await productsRemoteDataSource.fetchCategories();
      final list = categories?.map((e) => e.toEntity()).toList() ?? [];
      return Right(list);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> fetchRelatedById({
    String? id,
  }) async {
    try {
      final products = await productsRemoteDataSource.fetchRelatedById(id: id);
      final list = products?.map((e) => e.toEntity()).toList() ?? [];
      return Right(list);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
