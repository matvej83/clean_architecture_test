import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';

class ProductsState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<ProductEntity> products;

  const ProductsState({
    this.isLoading = false,
    this.error,
    this.products = const [],
  });

  ProductsState copyWith({
    bool? isLoading,
    String? error,
    List<ProductEntity>? products,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, products];
}
