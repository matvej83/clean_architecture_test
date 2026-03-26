import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';

class ProductsState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;

  const ProductsState({
    this.isLoading = false,
    this.error,
    this.products = const [],
    this.categories = const [],
  });

  ProductsState copyWith({
    bool? isLoading,
    String? error,
    List<ProductEntity>? products,
    List<CategoryEntity>? categories,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      products: products ?? this.products,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, products, categories];
}
