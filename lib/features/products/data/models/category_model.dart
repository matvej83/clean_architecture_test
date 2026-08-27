import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:store_app/features/products/domain/entity/category_entity.dart';

import '../../../../utils.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const CategoryModel._();

  const factory CategoryModel({
    @JsonKey(includeFromJson: true, includeToJson: false) int? id,
    required String name,
    required String image,
    @JsonKey(includeFromJson: true, includeToJson: false) String? slug,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  static List<CategoryModel> fromList(List<dynamic> list) {
    return AppUtils.parseList<CategoryModel>(list, CategoryModel.fromJson);
  }
}

extension CategoryModelExt on CategoryModel {
  CategoryEntity toEntity() => CategoryEntity(
    id: (id ?? 0).toString(),
    name: name,
    image: image,
    slug: slug ?? '',
  );
}
