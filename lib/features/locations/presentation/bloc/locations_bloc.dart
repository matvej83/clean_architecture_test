import 'dart:async';

import 'package:clean_architecture_test/core/services/geolocation_service.dart';
import 'package:clean_architecture_test/features/locations/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/failure.dart';
import '../../domain/usecases/fetch_products_usecase.dart';
import 'locations_event.dart';
import 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState>
    with WidgetsBindingObserver {
  final FetchLocationsUseCase fetchLocationsUseCase;
  final GeolocationService geolocationService;

  StreamSubscription? _locationSub;

  LocationsBloc({
    required this.fetchLocationsUseCase,
    required this.geolocationService,
  }) : super(const LocationsState()) {
    on<LocationsFetched>(_onLocationsFetched);
    on<LocationSelected>(_onLocationSelected);
    on<LocationUpdated>(_onLocationUpdated);
    WidgetsBinding.instance.addObserver(this);
    geolocationService.startTracking();
    _locationSub = geolocationService.onLocationChanged.listen((position) {
      add(LocationUpdated(position));
    });
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    _locationSub?.cancel();
    return super.close();
  }

  Position? position;
  var locationAsked = false;

  FutureOr<void> _onLocationsFetched(
    LocationsFetched event,
    Emitter<LocationsState> emit,
  ) async {
    if (!event.loadSilent) {
      emit(state.copyWith(isLoading: true));
    }
    if (position == null && !locationAsked) {
      position = await geolocationService.getCurrentPosition();
      locationAsked = true;
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
          final markers = LocationsUtil.makeMarkers(
            locations: r,
            selectedLocation: (state.selectedLocationId?.isNotEmpty == true)
                ? state.selectedLocation
                : null,
          );
          var locations = r;
          if (position != null) {
            locations = LocationsUtil.addGeolocationToList(
              locations: r,
              position: position!,
            );
          }
          emit(
            state.copyWith(
              locations: locations,
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

  FutureOr<void> _onLocationSelected(
    LocationSelected event,
    Emitter<LocationsState> emit,
  ) async {
    final markers = LocationsUtil.makeMarkers(
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

  FutureOr<void> _onLocationUpdated(
    LocationUpdated event,
    Emitter<LocationsState> emit,
  ) {
    if (state.locations.isNotEmpty &&
        (position == null ||
            !LocationsUtil.isSamePosition(position!, event.position))) {
      position = event.position;
      final updatedLocations = LocationsUtil.addGeolocationToList(
        locations: state.locations,
        position: event.position,
      );

      emit(state.copyWith(locations: updatedLocations));
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final pos = await geolocationService.getCurrentPosition();
      if (pos != null) {
        add(LocationUpdated(pos));
      }
    }
  }
}
