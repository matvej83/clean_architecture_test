import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';

part 'category_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required int id,
    required String name,
    required String image,
    required String slug,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

extension CategoryModelExt on CategoryModel {
  CategoryEntity toEntity() =>
      CategoryEntity(id: id.toString(), name: name, image: image, slug: slug);
}
