import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_entity.freezed.dart';

@Freezed(toJson: false, fromJson: false, equal: true, copyWith: true)
abstract class LocationEntity with _$LocationEntity {
  const factory LocationEntity({
    required String id,
    required String name,
    required String description,
    required double latitude,
    required double longitude,
    double? distance,
  }) = _LocationEntity;
}
