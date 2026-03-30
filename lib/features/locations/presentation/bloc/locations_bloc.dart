import 'dart:async';

import 'package:clean_architecture_test/features/locations/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/failure.dart';
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
          final markers = LocationsUtil.makeMarkers(
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
}
