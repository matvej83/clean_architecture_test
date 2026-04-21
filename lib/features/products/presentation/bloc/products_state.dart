import 'package:clean_architecture_test/core/domain/entity/avaliability_filter_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/app_image_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_state.freezed.dart';

@freezed
abstract class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default(false) bool isLoading,
    @Default(false) bool isProductLoading,

    /// pagination
    @Default(false) bool isShowProductLoader,
    @Default(false) bool hasReachedMaxProducts,

    @Default(false) bool createdSuccessful,
    @Default(false) bool isCreating,
    String? error,
    String? search,
    @Default([]) List<ProductEntity> products,
    @Default([]) List<ProductEntity> relatedById,
    ProductEntity? product,
    @Default([]) List<CategoryEntity> categories,
    @Default('') String selectedCategoryId,
    @Default('') String createdProductCategoryId,
    List<AppImageEntity>? pickedImages,
    List<String>? uploadedImages,
    @Default([]) List<AvailabilityFilterEntity> filters,
  }) = _ProductsState;
}
