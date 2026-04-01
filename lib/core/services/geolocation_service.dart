import 'dart:async';
import 'dart:developer';
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
  ///   }) : super(const GeolocationsState()) {
  ///     on<GeolocationUpdated>(_onUpdateGeolocation);
  ///     ...
  ///     WidgetsBinding.instance.addObserver(this);
  ///     geolocationService.startTracking();
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
  ///     Emitter<GeolocationsState> emit,
  ///   ) {
  ///      // handle update
  ///   }
  ///   ...
  ///
  /// @override
  ///   Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  ///     if (state == AppLifecycleState.resumed) {
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
  bool _isRestarting = false;
  int _attempts = 0;
  DateTime? _lastEmit;

  static const LocationSettings _locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 20,
  );

  Future<void> startTracking() async {
    if (_isTracking) return;

    final hasPermission = await _ensurePermission();
    if (!hasPermission) return;

    try {
      _positionSub =
          Geolocator.getPositionStream(
            locationSettings: _locationSettings,
          ).listen(
            (position) {
              _attempts = 0;
              if (!_controller.isClosed) {
                final now = DateTime.now();

                if (_lastEmit == null ||
                    now.difference(_lastEmit!) > const Duration(seconds: 2)) {
                  _lastEmit = now;
                  _controller.add(position);
                }
              }
            },
            onError: (e) async {
              log(e.toString());
              if (_isRestarting) return;

              if (_attempts < 2) {
                _attempts++;
                _isRestarting = true;
                await restartTracking();
                _isRestarting = false;
              }
            },
          );
      _isTracking = true;
    } catch (e) {
      _isTracking = false;
      rethrow;
    }
  }

  Future<void> stopTracking() async {
    await _positionSub?.cancel();
    _positionSub = null;
    _isTracking = false;
  }

  Future<void> restartTracking() async {
    _lastEmit = null;
    await stopTracking();
    await startTracking();
  }

  Future<Position?> getCurrentPosition() async {
    final hasPermission = await _ensurePermission();
    if (!hasPermission) return null;

    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
    } catch (_) {
      return await Geolocator.getLastKnownPosition();
    }
  }

  Future<bool> isLocationEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  Future<bool> _ensurePermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return false;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      return false;
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }

    return true;
  }
}
