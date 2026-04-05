import 'package:clean_architecture_test/features/products/domain/entity/image_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_model.freezed.dart';

part 'image_model.g.dart';

@freezed
abstract class ImageModel with _$ImageModel {
  const factory ImageModel({
    required String originalname,
    required String filename,
    required String location,
  }) = _ImageModel;

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
}

extension ImageModelExt on ImageModel {
  ImageEntity toEntity() => ImageEntity(
    originalname: originalname,
    filename: filename,
    location: location,
  );
}
