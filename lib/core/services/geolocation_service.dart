import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import 'geolocation_service_interface.dart';

/// Geolocation service that provides a stream of location updates
/// and methods for managing tracking.
///
/// Uses the `geolocator` package and supports:
/// - permission request
/// - geolocation status checking
/// - streaming coordinate update
/// - current position getting
///
/// Example of using in BLoC:
/// ```dart
/// class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState>
///     with WidgetsBindingObserver {
///   final IGeolocationService geolocationService;
///
///   StreamSubscription? _locationSub;
///
///   GeolocationBloc({
///     required this.geolocationService,
///   }) : super(const GeolocationState()) {
///     on<GeolocationUpdated>(_onUpdateGeolocation);
///     WidgetsBinding.instance.addObserver(this);
///     geolocationService.init();
///     _locationSub = geolocationService.onLocationChanged.listen((position) {
///       add(GeolocationUpdated(position));
///     });
///   }
///
///   @override
///   Future<void> close() {
///     WidgetsBinding.instance.removeObserver(this);
///     _locationSub?.cancel();
///     return super.close();
///   }
///
///   FutureOr<void> _onUpdateGeolocation(
///     GeolocationUpdated event,
///     Emitter<GeolocationState> emit,
///   ) {
///     // handle update
///   }
///
///   @override
///   Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
///     if (state == AppLifecycleState.resumed && !kIsWeb) {
///       final pos = await geolocationService.getCurrentPosition();
///       if (pos != null) {
///         add(GeolocationUpdated(pos));
///       }
///     }
///   }
/// }
/// ```

@LazySingleton(as: IGeolocationService)
class GeolocationService implements IGeolocationService {
  final StreamController<Position> _controller =
      StreamController<Position>.broadcast();

  StreamSubscription<Position>? _positionSub;

  bool _isTracking = false;
  DateTime? _lastEmit;
  DateTime? _lastRestart;

  static const _locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 20,
  );

  @override
  Stream<Position> get onLocationChanged => _controller.stream;

  @override
  Future<void> init() async {
    if (kIsWeb) return;

    final granted = await requestPermission();
    final enabled = await Geolocator.isLocationServiceEnabled();

    if (granted && enabled) {
      await startTracking();
    }
  }

  @override
  Future<bool> requestPermission() async {
    try {
      final locationPermission = await Geolocator.requestPermission();
      return locationPermission == LocationPermission.whileInUse ||
          locationPermission == LocationPermission.always;
    } catch (e) {
      log('Geolocation: permission request error: $e');
      return false;
    }
  }

  @override
  Future<bool> hasPermission() async {
    try {
      final locationPermission = await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        return false;
      }

      return locationPermission == LocationPermission.whileInUse ||
          locationPermission == LocationPermission.always;
    } catch (e) {
      log('Geolocation: permission check error: $e');
      return false;
    }
  }

  @override
  Future<void> startTracking() async {
    if (_isTracking) return;

    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        log('Geolocation: service disabled');
        return;
      }

      final hasGeoPermission = await hasPermission();
      if (!hasGeoPermission) {
        log('Geolocation: no permission, tracking not started');
        return;
      }

      _positionSub = Geolocator.getPositionStream(
        locationSettings: _locationSettings,
      ).listen(_onPosition, onError: _onError);

      _isTracking = true;
    } catch (e) {
      log('Geolocation start error: $e');
      _isTracking = false;
    }
  }

  @override
  Future<void> stopTracking() async {
    await _positionSub?.cancel();
    _positionSub = null;
    _isTracking = false;
  }

  @override
  Future<void> restartTracking() async {
    if (kIsWeb) return;

    await stopTracking();
    await startTracking();
  }

  @override
  Future<Position?> getCurrentPosition() async {
    try {
      final hasGeoPermission = await hasPermission();
      final enabled = await Geolocator.isLocationServiceEnabled();

      if (!hasGeoPermission || !enabled) return null;

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
    } catch (e) {
      log('Geolocation getCurrentPosition error: $e');

      if (kIsWeb) return null;

      return await Geolocator.getLastKnownPosition();
    }
  }

  void _onPosition(Position position) {
    final now = DateTime.now();

    if (_lastEmit != null &&
        now.difference(_lastEmit!) < const Duration(seconds: 2)) {
      return;
    }

    _lastEmit = now;

    if (!_controller.isClosed) {
      _controller.add(position);
    }
  }

  Future<void> _onError(Object error) async {
    log('Geolocation stream error: $error');
    _isTracking = false;

    if (kIsWeb) return;

    final enabled = await Geolocator.isLocationServiceEnabled();

    if (!enabled) {
      log('Geolocation: service disabled → stop retrying');
      return;
    }

    final now = DateTime.now();
    if (_lastRestart != null &&
        now.difference(_lastRestart!) < const Duration(seconds: 5)) {
      return;
    }
    _lastRestart = now;

    await restartTracking();
  }

  @override
  Future<void> dispose() async {
    await stopTracking();
    await _controller.close();
  }
}
