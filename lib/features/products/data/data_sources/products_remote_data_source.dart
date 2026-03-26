import 'package:clean_architecture_test/core/error/exception.dart';
import 'package:clean_architecture_test/features/products/data/models/category_model.dart';
import 'package:clean_architecture_test/features/products/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>?> fetchProducts({String? categoryId});

  Future<List<ProductModel>?> fetchRelatedById({String? id});

  Future<ProductModel?> fetchProduct({String? id});

  Future<List<CategoryModel>?> fetchCategories();
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
}
