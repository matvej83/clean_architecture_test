import 'package:clean_architecture_test/features/locations/domain/entity/location_entity.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationsUtil {
  static LocationEntity? getLocationByLatLong({
    required LatLng latLng,
    required List<LocationEntity> locations,
  }) {
    final result = locations.firstWhereOrNull(
      (e) => e.latitude == latLng.latitude && e.longitude == e.longitude,
    );
    return result;
  }

  static List<Marker> makeMarkers({
    required List<LocationEntity> locations,
    LocationEntity? selectedLocation,
  }) {
    var markers = <Marker>[];
    for (var e in locations) {
      final isSelected =
          e.latitude == selectedLocation?.latitude &&
          e.longitude == selectedLocation?.longitude;
      markers.add(
        Marker(
          width: 40,
          height: 40,
          point: LatLng(e.latitude, e.longitude),
          child: Icon(
            Icons.location_pin,
            color: isSelected ? Colors.red : Colors.blue,
            size: 40,
          ),
        ),
      );
    }
    return markers;
  }

  static double getDistance(LatLng from, LatLng to) =>
      const Distance().as(LengthUnit.Kilometer, from, to);

  static List<LocationEntity> addGeolocationToList({
    required List<LocationEntity> locations,
    required Position position,
  }) {
    var list = <LocationEntity>[];
    for (var e in locations) {
      final from = LatLng(position.latitude, position.longitude);
      final to = LatLng(e.latitude, e.longitude);
      list.add(e.copyWith(distance: getDistance(from, to)));
    }
    return list;
  }

  static bool isSamePosition(Position a, Position b) {
    return a.latitude == b.latitude && a.longitude == b.longitude;
  }
}
