import 'package:geolocator/geolocator.dart';

/// Interface for geolocation functionality.
/// Provides methods for permission handling, tracking, and position retrieval.
abstract class IGeolocationService {
  /// Stream of location updates.
  Stream<Position> get onLocationChanged;

  /// Initialize the service (request permission and start tracking if possible).
  Future<void> init();

  /// Request location permission from the user.
  Future<bool> requestPermission();

  /// Check if permission is already granted.
  Future<bool> hasPermission();

  /// Start listening to location updates.
  Future<void> startTracking();

  /// Stop listening to location updates.
  Future<void> stopTracking();

  /// Restart tracking (stop then start).
  Future<void> restartTracking();

  /// Get the current position (or null if unavailable).
  Future<Position?> getCurrentPosition();

  /// Dispose resources.
  Future<void> dispose();
}
