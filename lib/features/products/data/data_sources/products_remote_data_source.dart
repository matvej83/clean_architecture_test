import 'dart:io';

import 'package:clean_architecture_test/core/error/exception.dart';
import 'package:clean_architecture_test/features/products/data/models/category_model.dart';
import 'package:clean_architecture_test/features/products/data/models/image_model.dart';
import 'package:clean_architecture_test/features/products/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>?> fetchProducts({String? categoryId});

  Future<List<ProductModel>?> fetchRelatedById({String? id});

  Future<ProductModel?> fetchProduct({String? id});

  Future<ProductModel?> createProduct({required ProductModel product});

  Future<List<CategoryModel>?> fetchCategories();

  Future<ImageModel?> uploadImage({required File imageFile});
}

@LazySingleton(as: ProductsRemoteDataSource)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio dio;

  ProductsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>?> fetchProducts({String? categoryId}) async {
    try {
      final endPoint = categoryId?.isNotEmpty == true
          ? 'categories/$categoryId/products'
          : 'products';
      final response = await dio.get(endPoint);
      if (response.data != null) {
        return ProductModel.fromList(response.data);
      }
    } on Exception catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        throw InvalidCredentialsException();
      } else {
        throw ServerException();
      }
    }
    return null;
  }

  @override
  Future<ProductModel?> fetchProduct({String? id}) async {
    try {
      final response = await dio.get('products/$id');
      if (response.data != null) {
        return ProductModel.fromJson(response.data);
      }
    } on Exception catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        throw InvalidCredentialsException();
      } else {
        throw ServerException();
      }
    }
    return null;
  }

  @override
  Future<List<CategoryModel>?> fetchCategories() async {
    try {
      final response = await dio.get('categories');
      if (response.data != null) {
        return CategoryModel.fromList(response.data);
      }
    } on Exception catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        throw InvalidCredentialsException();
      } else {
        throw ServerException();
      }
    }
    return null;
  }

  @override
  Future<List<ProductModel>?> fetchRelatedById({String? id}) async {
    try {
      final response = await dio.get('products/$id/related');
      if (response.data != null) {
        return ProductModel.fromList(response.data);
      }
    } on Exception catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        throw InvalidCredentialsException();
      } else {
        throw ServerException();
      }
    }
    return null;
  }

  @override
  Future<ImageModel?> uploadImage({required File imageFile}) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: path.basename(imageFile.path),
        ),
      });
      final response = await dio.post('files/upload', data: formData);
      if (response.data != null) {
        return ImageModel.fromJson(response.data);
      }
    } on Exception catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        throw InvalidCredentialsException();
      } else {
        throw ServerException();
      }
    }
    return null;
  }

  @override
  Future<ProductModel?> createProduct({required ProductModel product}) async {
    try {
      final response = await dio.post('products/', data: product.toJson());
      if (response.data != null) {
        return ProductModel.fromJson(response.data);
      }
    } on Exception catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        throw InvalidCredentialsException();
      } else {
        throw ServerException();
      }
    }
    return null;
  }
}
