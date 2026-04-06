import 'dart:io';

import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/features/products/data/models/category_model.dart';
import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/image_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/product_model.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> fetchProducts({
    String? categoryId,
  });

  Future<Either<Failure, List<ProductEntity>>> fetchRelatedById({String? id});

  Future<Either<Failure, ProductEntity>> fetchProduct({String? id});

  Future<Either<Failure, ProductEntity>> createProduct({
    required ProductModel product,
  });

  Future<Either<Failure, bool>> deleteProduct({required int id});

  Future<Either<Failure, bool>> deleteCategory({required int id});

  Future<Either<Failure, List<CategoryEntity>>> fetchCategories();

  Future<Either<Failure, CategoryEntity>> createCategory({
    required CategoryModel category,
  });

  Future<Either<Failure, ImageEntity>> uploadImage({required File imageFile});
}
