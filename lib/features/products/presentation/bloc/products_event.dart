import 'package:clean_architecture_test/core/domain/entity/avaliability_filter_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/app_image_entity.dart';

part 'products_event.freezed.dart';

@freezed
class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.productsFetched({
    String? categoryId,
    String? search,
    @Default(true) bool loadSilent,
  }) = ProductsFetched;

  const factory ProductsEvent.categoriesFetched({
    @Default(true) bool loadSilent,
  }) = CategoriesFetched;

  const factory ProductsEvent.productFetched(String id) = ProductFetched;

  const factory ProductsEvent.relatedByIdFetched(String id) =
      RelatedByIdFetched;

  const factory ProductsEvent.createdProductCategorySelected({
    required String categoryId,
  }) = CreatedProductCategorySelected;

  const factory ProductsEvent.productCreated({
    required String title,
    required String description,
    required int price,
  }) = ProductCreated;

  const factory ProductsEvent.productDeleted({required int id}) =
      ProductDeleted;

  const factory ProductsEvent.categoryCreated({required String name}) =
      CategoryCreated;

  const factory ProductsEvent.categoryDeleted({required int id}) =
      CategoryDeleted;

  const factory ProductsEvent.imagePicked() = ImagePicked;

  const factory ProductsEvent.imageRemoved({required AppImageEntity image}) =
      ImageRemoved;

  const factory ProductsEvent.imageUploaded({required AppImageEntity image}) =
      ImageUploaded;

  const factory ProductsEvent.dataRemoved() = DataRemoved;

  const factory ProductsEvent.filterAdded({
    required AvailabilityFilterEntity filter,
  }) = FilterAdded;

  const factory ProductsEvent.filterRemoved({
    required AvailabilityFilterEntity filter,
  }) = FilterRemoved;

  const factory ProductsEvent.filtersSaved({
    required List<AvailabilityFilterEntity> filters,
  }) = FiltersSaved;
}
