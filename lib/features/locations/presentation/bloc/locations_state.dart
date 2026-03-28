import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entity/location_entity.dart';

class LocationsState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<LocationEntity> locations;
  final String? selectedLocationId;
  final LocationEntity? selectedLocation;
  final List<Marker> markers;
  final LatLng center;

  const LocationsState({
    this.isLoading = false,
    this.error,
    this.locations = const [],
    this.selectedLocationId,
    this.selectedLocation,
    this.markers = const [],
    this.center = const LatLng(50.4501, 30.5234),
  });

  LocationsState copyWith({
    bool? isLoading,
    String? error,
    List<LocationEntity>? locations,
    String? selectedLocationId,
    LocationEntity? selectedLocation,
    List<Marker>? markers,
    LatLng? center,
  }) {
    return LocationsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      locations: locations ?? this.locations,
      selectedLocationId: selectedLocationId ?? this.selectedLocationId,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      markers: markers ?? this.markers,
      center: center ?? this.center,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    error,
    locations,
    selectedLocationId,
    selectedLocation,
    markers,
  ];
}
