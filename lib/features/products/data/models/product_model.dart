import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'category_model.dart';

part 'product_model.freezed.dart';

part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    @JsonKey(includeToJson: false, includeFromJson: true) int? id,
    required String title,
    @JsonKey(includeToJson: false, includeFromJson: true) String? slug,
    required int price,
    required String description,
    @JsonKey(includeToJson: false, includeFromJson: true)
    CategoryModel? category,
    @JsonKey(includeToJson: true, includeFromJson: false) int? categoryId,
    @JsonKey(defaultValue: []) required List<String> images,
    DateTime? creationAt,
    DateTime? updatedAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  static List<ProductModel> fromList(List<dynamic> list) {
    return list
        .map(
          (jsonItem) => ProductModel.fromJson(jsonItem as Map<String, dynamic>),
        )
        .toList();
  }
}

extension ProductModelExt on ProductModel {
  ProductEntity toEntity() => ProductEntity(
    id: id.toString(),
    title: title,
    slug: slug ?? '',
    price: price,
    description: description,
    category: category!.toEntity(),
    images: images,
    creationAt: creationAt,
    updatedAt: updatedAt,
  );
}
