import 'package:clean_architecture_test/features/locations/domain/entity/location_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationsFetched extends LocationsEvent {
  final List<double>? origin;
  final int? radius;
  final bool loadSilent;

  LocationsFetched({this.origin, this.radius, this.loadSilent = true});

  @override
  List<Object?> get props => [origin, radius, loadSilent];
}

class LocationSelected extends LocationsEvent {
  final String? locationId;
  final LocationEntity? location;

  LocationSelected({this.locationId, this.location});

  @override
  List<Object?> get props => [locationId, location];
}

class LocationUpdated extends LocationsEvent {
  final Position position;

  LocationUpdated(this.position);
}

class GeoStatusChecked extends LocationsEvent {}

class GeoStatusModalDisabled extends LocationsEvent {}
