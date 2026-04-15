import 'package:flutter_map/flutter_map.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entity/location_entity.dart';

part 'locations_state.freezed.dart';

@freezed
abstract class LocationsState with _$LocationsState {
  const factory LocationsState({
    @Default(false) bool isLoading,
    @Default(false) bool showGeoModal,
    String? error,
    @Default([]) List<LocationEntity> locations,
    String? selectedLocationId,
    LocationEntity? selectedLocation,
    @Default([]) List<Marker> markers,
    @Default(LatLng(50.4501, 30.5234)) LatLng center,
  }) = _LocationsState;
}
