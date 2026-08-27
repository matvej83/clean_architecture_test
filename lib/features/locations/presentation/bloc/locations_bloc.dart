import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:store_app/core/services/geolocation_service_interface.dart';
import 'package:store_app/features/locations/utils.dart';

import '../../../../core/error/failure.dart';
import '../../domain/usecases/fetch_locations_usecase.dart';
import 'locations_event.dart';
import 'locations_state.dart';

@lazySingleton
class LocationsBloc extends Bloc<LocationsEvent, LocationsState>
    with WidgetsBindingObserver {
  LocationsBloc(this._fetchLocationsUseCase, this._geolocationService)
    : super(const LocationsState()) {
    on<LocationsEvent>((event, emit) async {
      await event.map(
        locationsFetched: (e) => _onLocationsFetched(e, emit),
        locationSelected: (e) => _onLocationSelected(e, emit),
        locationUpdated: (e) => _onLocationUpdated(e, emit),
        geoStatusChecked: (e) => _onGeoStatusChecked(e, emit),
        geoStatusModalDisabled: (e) => _onGeoStatusModalDisabled(e, emit),
      );
    });
    WidgetsBinding.instance.addObserver(this);
    _geolocationService.init();
    _locationSub = _geolocationService.onLocationChanged.listen((position) {
      add(LocationUpdated(position: position));
    });
  }

  final FetchLocationsUseCase _fetchLocationsUseCase;
  final IGeolocationService _geolocationService;

  StreamSubscription? _locationSub;

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    _locationSub?.cancel();
    return super.close();
  }

  Position? position;
  var locationAsked = false;

  Future<void> _onLocationsFetched(
    LocationsFetched event,
    Emitter<LocationsState> emit,
  ) async {
    if (!event.loadSilent) {
      emit(state.copyWith(isLoading: true));
    }
    if (!kIsWeb && position == null && !locationAsked) {
      position = await _geolocationService.getCurrentPosition();
      locationAsked = true;
    }
    final result = await _fetchLocationsUseCase(
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
          final markers = LocationsUtils.makeMarkers(
            locations: r,
            selectedLocation: (state.selectedLocationId?.isNotEmpty == true)
                ? state.selectedLocation
                : null,
          );
          var locations = r;
          if (position != null) {
            locations = LocationsUtils.addGeolocationToList(
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

  Future<void> _onLocationSelected(
    LocationSelected event,
    Emitter<LocationsState> emit,
  ) async {
    final markers = LocationsUtils.makeMarkers(
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

  Future<void> _onLocationUpdated(
    LocationUpdated event,
    Emitter<LocationsState> emit,
  ) async {
    if (state.locations.isNotEmpty &&
        (position == null ||
            !LocationsUtils.isSamePosition(position!, event.position))) {
      position = event.position;
      final updatedLocations = LocationsUtils.addGeolocationToList(
        locations: state.locations,
        position: event.position,
      );

      emit(state.copyWith(locations: updatedLocations));
    }
  }

  Future<void> _onGeoStatusChecked(
    GeoStatusChecked event,
    Emitter<LocationsState> emit,
  ) async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      emit(state.copyWith(showGeoModal: true));
    }
  }

  Future<void> _onGeoStatusModalDisabled(
    GeoStatusModalDisabled event,
    Emitter<LocationsState> emit,
  ) async {
    emit(state.copyWith(showGeoModal: false));
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && !kIsWeb) {
      final pos = await _geolocationService.getCurrentPosition();
      if (pos != null) {
        add(LocationUpdated(position: pos));
      }
    }
  }
}
