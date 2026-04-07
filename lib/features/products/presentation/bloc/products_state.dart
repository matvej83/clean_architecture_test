import 'dart:io';

import 'package:clean_architecture_test/core/domain/entity/avaliability_filter_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';

class ProductsState extends Equatable {
  final bool isLoading;
  final bool isProductLoading;
  final bool createdSuccessful;
  final bool isCreating;
  final String? error;
  final List<ProductEntity> products;
  final List<ProductEntity> relatedById;
  final ProductEntity? product;
  final List<CategoryEntity> categories;
  final String selectedCategoryId;
  final String createdProductCategoryId;
  final List<File>? pickedImages;
  final List<String>? uploadedImages;
  final List<AvailabilityFilterEntity> filters;

  const ProductsState({
    this.isLoading = false,
    this.isProductLoading = false,
    this.createdSuccessful = false,
    this.isCreating = false,
    this.error,
    this.products = const [],
    this.relatedById = const [],
    this.product,
    this.categories = const [],
    this.selectedCategoryId = '',
    this.createdProductCategoryId = '',
    this.pickedImages,
    this.uploadedImages,
    this.filters = const [],
  });

  ProductsState copyWith({
    bool? isLoading,
    bool? isProductLoading,
    bool? createdSuccessful,
    bool? isCreating,
    String? error,
    List<ProductEntity>? products,
    List<ProductEntity>? relatedById,
    ProductEntity? product,
    List<CategoryEntity>? categories,
    String? selectedCategoryId,
    String? createdProductCategoryId,
    List<File>? pickedImages,
    List<String>? uploadedImages,
    List<AvailabilityFilterEntity>? filters,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      isProductLoading: isProductLoading ?? this.isProductLoading,
      createdSuccessful: createdSuccessful ?? this.createdSuccessful,
      isCreating: isCreating ?? this.isCreating,
      error: error,
      products: products ?? this.products,
      relatedById: relatedById ?? this.relatedById,
      product: product ?? this.product,
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      createdProductCategoryId:
          createdProductCategoryId ?? this.createdProductCategoryId,
      pickedImages: pickedImages ?? this.pickedImages,
      uploadedImages: uploadedImages ?? this.uploadedImages,
      filters: filters ?? this.filters,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isProductLoading,
    isCreating,
    createdSuccessful,
    error,
    products,
    relatedById,
    product,
    categories,
    selectedCategoryId,
    createdProductCategoryId,
    pickedImages,
    uploadedImages,
    filters,
  ];
}
