import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'category_model.dart';

part 'product_model.freezed.dart';

part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required int id,
    required String title,
    required String slug,
    required int price,
    required String description,
    required CategoryModel category,
    @JsonKey(defaultValue: []) required List<String> images,
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
    slug: slug,
    price: price,
    description: description,
    category: category.toEntity(),
    images: images,
  );
}
