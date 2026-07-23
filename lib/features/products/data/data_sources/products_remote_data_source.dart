import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/network/base_remote_data_source.dart';
import 'package:store_app/features/products/data/models/category_model.dart';
import 'package:store_app/features/products/data/models/image_model.dart';
import 'package:store_app/features/products/data/models/product_model.dart';

import '../../domain/entity/app_image_entity.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>?> fetchProducts({
    String? categoryId,
    String? search,
    int? priceMin,
    int? priceMax,
    int? offset,
    int? limit,
  });

  Future<List<ProductModel>?> fetchRelatedById({String? id});

  Future<ProductModel?> fetchProduct({String? id});

  Future<ProductModel?> createProduct({required ProductModel product});

  Future<bool> deleteProduct({required int id});

  Future<bool> deleteCategory({required int id});

  Future<List<CategoryModel>?> fetchCategories();

  Future<CategoryModel?> createCategory({required CategoryModel category});

  Future<ImageModel?> uploadImage({required AppImageEntity imageFile});
}

@LazySingleton(as: ProductsRemoteDataSource)
class ProductsRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ProductsRemoteDataSource {
  ProductsRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<ProductModel>?> fetchProducts({
    String? categoryId,
    String? search,
    int? priceMin,
    int? priceMax,
    int? offset,
    int? limit,
  }) async {
    return makeRequest<List<ProductModel>?>(() async {
      final Map<String, dynamic> queryParameters = {};
      if (categoryId?.isNotEmpty == true) {
        queryParameters.addAll({'categoryId': categoryId});
      }
      if (search?.isNotEmpty == true) {
        queryParameters.addAll({'title': search});
      }
      if (priceMin != null) {
        queryParameters.addAll({'price_min': priceMin});
      }
      if (priceMax != null) {
        queryParameters.addAll({'price_max': priceMax});
      }
      if (offset != null && limit != null) {
        queryParameters.addAll({'offset': offset, 'limit': limit});
      }

      final response = await dio.get(
        'products',
        queryParameters: queryParameters,
      );
      if (response.data != null) {
        return ProductModel.fromList(response.data);
      }
      return null;
    });
  }

  @override
  Future<ProductModel?> fetchProduct({String? id}) async {
    return makeRequest<ProductModel?>(() async {
      final response = await dio.get('products/$id');
      if (response.data != null) {
        return ProductModel.fromJson(response.data);
      }
      return null;
    });
  }

  @override
  Future<List<CategoryModel>?> fetchCategories() async {
    return makeRequest<List<CategoryModel>?>(() async {
      final response = await dio.get('categories');
      if (response.data != null) {
        return CategoryModel.fromList(response.data);
      }
      return null;
    });
  }

  @override
  Future<List<ProductModel>?> fetchRelatedById({String? id}) async {
    return makeRequest<List<ProductModel>?>(() async {
      final response = await dio.get('products/$id/related');
      if (response.data != null) {
        return ProductModel.fromList(response.data);
      }
      return null;
    });
  }

  @override
  Future<ImageModel?> uploadImage({required AppImageEntity imageFile}) async {
    return makeRequest<ImageModel?>(() async {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          imageFile.bytes,
          filename: imageFile.name,
        ),
      });
      final response = await dio.post('files/upload', data: formData);
      if (response.data != null) {
        return ImageModel.fromJson(response.data);
      }
      return null;
    });
  }

  @override
  Future<ProductModel?> createProduct({required ProductModel product}) async {
    return makeRequest<ProductModel?>(() async {
      final response = await dio.post('products/', data: product.toJson());
      if (response.data != null) {
        return ProductModel.fromJson(response.data);
      }
      return null;
    });
  }

  @override
  Future<CategoryModel?> createCategory({
    required CategoryModel category,
  }) async {
    return makeRequest<CategoryModel?>(() async {
      final response = await dio.post('categories/', data: category.toJson());
      if (response.data != null) {
        return CategoryModel.fromJson(response.data);
      }
      return null;
    });
  }

  @override
  Future<bool> deleteProduct({required int id}) async {
    return makeRequest<bool>(() async {
      final response = await dio.delete('products/$id');
      return response.statusCode == 200;
    });
  }

  @override
  Future<bool> deleteCategory({required int id}) async {
    return makeRequest<bool>(() async {
      final response = await dio.delete('categories/$id');
      return response.statusCode == 200;
    });
  }
}
