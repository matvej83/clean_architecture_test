import 'dart:async';

import 'package:clean_architecture_test/core/services/geolocation_service.dart';
import 'package:clean_architecture_test/features/locations/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
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
    geolocationService.init();
    _locationSub = geolocationService.onLocationChanged.listen((position) {
      add(LocationUpdated(position: position));
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

  Future<void> _onLocationsFetched(
    LocationsFetched event,
    Emitter<LocationsState> emit,
  ) async {
    if (!event.loadSilent) {
      emit(state.copyWith(isLoading: true));
    }
    if (!kIsWeb && position == null && !locationAsked) {
      if (await geolocationService.hasPermission()) {
        position = await geolocationService.getCurrentPosition();
      }
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

  Future<void> _onLocationSelected(
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

  Future<void> _onLocationUpdated(
    LocationUpdated event,
    Emitter<LocationsState> emit,
  ) async {
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

  Future<void> _onGeoStatusChecked(
    GeoStatusChecked event,
    Emitter<LocationsState> emit,
  ) async {
    final permissionStatus = await Geolocator.checkPermission();
    if (permissionStatus == LocationPermission.deniedForever) {
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
      final pos = await geolocationService.getCurrentPosition();
      if (pos != null) {
        add(LocationUpdated(position: pos));
      }
    }
  }
}
