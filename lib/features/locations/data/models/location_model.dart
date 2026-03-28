import 'package:clean_architecture_test/features/locations/domain/entity/location_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.freezed.dart';

part 'location_model.g.dart';

@freezed
abstract class LocationModel with _$LocationModel {
  const LocationModel._();

  const factory LocationModel({
    required int id,
    required String name,
    required String description,
    required double latitude,
    required double longitude,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  static List<LocationModel> fromList(List<dynamic> list) {
    return list
        .map(
          (jsonItem) =>
              LocationModel.fromJson(jsonItem as Map<String, dynamic>),
        )
        .toList();
  }
}

extension LocationModelExt on LocationModel {
  LocationEntity toEntity() => LocationEntity(
    id: id.toString(),
    name: name,
    description: description,
    latitude: latitude,
    longitude: longitude,
  );
}
