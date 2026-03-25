import 'package:clean_architecture_test/core/error/exception.dart';
import 'package:clean_architecture_test/features/products/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>?> fetchProducts();
}

@LazySingleton(as: ProductsRemoteDataSource)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio dio;

  ProductsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>?> fetchProducts() async {
    try {
      final response = await dio.get('products');
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
