import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/location_entity.dart';
import '../../domain/usecases/fetch_products_usecase.dart';
import 'locations_event.dart';
import 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final FetchLocationsUseCase fetchLocationsUseCase;

  LocationsBloc({required this.fetchLocationsUseCase})
    : super(const LocationsState()) {
    on<LocationsFetched>(_onLocationsFetched);
    on<LocationSelected>(_onLocationSelected);
  }

  FutureOr<void> _onLocationsFetched(
    LocationsFetched event,
    Emitter<LocationsState> emit,
  ) async {
    if (!event.loadSilent) {
      emit(state.copyWith(isLoading: true));
    }
    final result = await fetchLocationsUseCase(
      FetchLocationsParams(origin: event.origin, radius: event.radius),
    );

    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        }
        emit(state.copyWith(error: message, isLoading: false));
      },
      (r) {
        if (r.isNotEmpty) {
          final center = LatLng(r.first.latitude, r.first.longitude);
          final markers = makeMarkers(
            locations: r,
            selectedLocation: (state.selectedLocationId?.isNotEmpty == true)
                ? state.selectedLocation
                : null,
          );
          emit(
            state.copyWith(
              locations: r,
              center: center,
              markers: markers,
              isLoading: false,
            ),
          );
        } else {
          emit(state.copyWith(locations: r, isLoading: false));
        }
      },
    );
  }

  List<Marker> makeMarkers({
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

  FutureOr<void> _onLocationSelected(
    LocationSelected event,
    Emitter<LocationsState> emit,
  ) async {
    final markers = makeMarkers(
      locations: state.locations,
      selectedLocation: event.locationId?.isNotEmpty == true
          ? event.location
          : null,
    );
    emit(
      state.copyWith(
        selectedLocationId: event.locationId,
        selectedLocation: event.location,
        markers: markers,
      ),
    );
  }
}
