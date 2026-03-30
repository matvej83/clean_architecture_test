import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeolocationService {
  final _controller = StreamController<Position>.broadcast();

  Stream<Position> get onLocationChanged => _controller.stream;

  Future<void> startTracking() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) return;

    Geolocator.getPositionStream().listen((position) {
      _controller.add(position);
    });
  }

  Future<Position?> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      final result = await Geolocator.requestPermission();
      if (result == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return null;
    }

    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          timeLimit: const Duration(seconds: 10),
        ),
      );
    } catch (e) {
      return await Geolocator.getLastKnownPosition();
    }
  }

  Future<void> stopTracking() async {
    await _controller.close();
  }

  Future<bool> _handlePermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final result = await Geolocator.requestPermission();
      return result != LocationPermission.denied;
    }
    return true;
  }
}
