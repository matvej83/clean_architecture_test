import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';

class ProductsState extends Equatable {
  final bool isLoading;
  final bool isProductLoading;
  final String? error;
  final List<ProductEntity> products;
  final ProductEntity? product;
  final List<CategoryEntity> categories;
  final String selectedCategoryId;

  const ProductsState({
    this.isLoading = false,
    this.isProductLoading = false,
    this.error,
    this.products = const [],
    this.product,
    this.categories = const [],
    this.selectedCategoryId = '',
  });

  ProductsState copyWith({
    bool? isLoading,
    bool? isProductLoading,
    String? error,
    List<ProductEntity>? products,
    ProductEntity? product,
    List<CategoryEntity>? categories,
    String? selectedCategoryId,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      isProductLoading: isProductLoading ?? this.isProductLoading,
      error: error,
      products: products ?? this.products,
      product: product ?? this.product,
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isProductLoading,
    error,
    products,
    product,
    categories,
    selectedCategoryId,
  ];
}
