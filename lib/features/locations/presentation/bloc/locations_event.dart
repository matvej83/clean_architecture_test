import 'package:clean_architecture_test/features/locations/domain/entity/location_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'locations_event.freezed.dart';

@freezed
class LocationsEvent with _$LocationsEvent {
  const factory LocationsEvent.locationsFetched({
    List<double>? origin,
    int? radius,
    @Default(false) bool loadSilent,
  }) = LocationsFetched;

  const factory LocationsEvent.locationSelected({
    String? locationId,
    LocationEntity? location,
  }) = LocationSelected;

  const factory LocationsEvent.locationUpdated({required Position position}) =
      LocationUpdated;

  const factory LocationsEvent.geoStatusChecked() = GeoStatusChecked;

  const factory LocationsEvent.geoStatusModalDisabled() =
      GeoStatusModalDisabled;
}
