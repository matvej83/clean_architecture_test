import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeolocationService {
  /// Example:
  ///
  /// ```dart
  /// class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState>
  ///     with WidgetsBindingObserver {
  ///   final GeolocationService geolocationService;
  ///
  ///   StreamSubscription? _locationSub;
  ///
  ///   GeolocationBloc({
  ///     required this.geolocationService,
  ///   }) : super(const GeolocationState()) {
  ///     on<GeolocationUpdated>(_onUpdateGeolocation);
  ///     ...
  ///     WidgetsBinding.instance.addObserver(this);
  ///     geolocationService.init();
  ///     _locationSub = geolocationService.onLocationChanged.listen((position) {
  ///       add(GeolocationUpdated(position));
  ///     });
  ///   }
  ///   ...
  ///
  ///   @override
  ///   Future<void> close() {
  ///     WidgetsBinding.instance.removeObserver(this);
  ///     _locationSub?.cancel();
  ///     return super.close();
  ///   }
  ///   ...
  ///
  /// FutureOr<void> _onUpdateGeolocation(
  ///     GeolocationUpdated event,
  ///     Emitter<GeolocationState> emit,
  ///   ) {
  ///      // handle update
  ///   }
  ///   ...
  ///
  /// @override
  ///   Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  ///     if (state == AppLifecycleState.resumed && !kIsWeb) {
  ///       final pos = await geolocationService.getCurrentPosition();
  ///       if (pos != null) {
  ///         add(GeolocationUpdated(pos));
  ///       }
  ///     }
  ///   }
  ///   ```

  final _controller = StreamController<Position>.broadcast();

  Stream<Position> get onLocationChanged => _controller.stream;

  StreamSubscription<Position>? _positionSub;

  bool _isTracking = false;
  DateTime? _lastEmit;

  static const _locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 20,
  );

  Future<void> init() async {
    if (kIsWeb) {
      return;
    }

    final granted = await requestPermission();
    if (granted) {
      await startTracking();
    }
  }

  /// Add this action to button
  Future<bool> requestPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return false;
    }

    final permission = await Geolocator.requestPermission();

    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<bool> hasPermission() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<void> startTracking() async {
    if (_isTracking) return;

    final hasGeoPermission = await hasPermission();
    if (!hasGeoPermission) {
      log('Geolocation: no permission, tracking not started');
      return;
    }

    try {
      _positionSub = Geolocator.getPositionStream(
        locationSettings: _locationSettings,
      ).listen(_onPosition, onError: _onError);

      _isTracking = true;
    } catch (e) {
      log('Geolocation start error: $e');
      _isTracking = false;
    }
  }

  Future<void> stopTracking() async {
    await _positionSub?.cancel();
    _positionSub = null;
    _isTracking = false;
  }

  Future<void> restartTracking() async {
    if (kIsWeb) {
      return;
    }

    await stopTracking();
    await startTracking();
  }

  Future<Position?> getCurrentPosition() async {
    final hasGeoPermission = await hasPermission();
    if (!hasGeoPermission) return null;

    try {
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

    if (kIsWeb) return;

    await restartTracking();
  }

  Future<void> dispose() async {
    await stopTracking();
    await _controller.close();
  }
}
