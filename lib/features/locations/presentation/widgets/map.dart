import 'package:clean_architecture_test/features/locations/domain/entity/location_entity.dart';
import 'package:clean_architecture_test/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:clean_architecture_test/features/locations/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class LocationsMap extends StatefulWidget {
  const LocationsMap({super.key});

  @override
  State<LocationsMap> createState() => _LocationsMapState();
}

class _LocationsMapState extends State<LocationsMap> {
  final MapController _mapController = MapController();
  Marker? _selectedMarker;
  LocationEntity? _tappedLocation;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LocationsBloc>().state;
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: state.center,
            initialZoom: 5.0,
            onTap: (tapPosition, latLng) {
              setState(() {
                _selectedMarker = null;
              });
            },
            onPositionChanged: (camera, _) {
              setState(() {});
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.vladimir.dev.cleanarchitecturetest',
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution('OpenStreetMap contributors'),
              ],
            ),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                maxClusterRadius: 45,
                size: Size(40, 40),
                markers: state.markers,
                builder: (context, cluster) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cluster.length.toString(),
                      style: textTheme.bodyMedium,
                    ),
                  );
                },
                onMarkerTap: (marker) {
                  setState(() {
                    _selectedMarker = marker;
                    _tappedLocation = LocationsUtil.getLocationByLatLong(
                      latLng: marker.point,
                      locations: state.locations,
                    );
                  });
                },
              ),
            ),
          ],
        ),
        if (_selectedMarker != null)
          _MapPopup(
            marker: _selectedMarker!,
            mapController: _mapController,
            location: _tappedLocation,
          ),
      ],
    );
  }
}

class _MapPopup extends StatelessWidget {
  final Marker marker;
  final LocationEntity? location;
  final MapController mapController;

  const _MapPopup({
    required this.marker,
    required this.mapController,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final offset = mapController.camera.latLngToScreenOffset(marker.point);
    final textTheme = Theme.of(context).textTheme;

    return Positioned(
      left: offset.dx - 100,
      top: offset.dy - 120,
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            spacing: 4.0,
            children: [
              Icon(Icons.shopping_cart, size: 16.0, color: Colors.blue),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location?.name ?? '',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      location?.description ?? '',
                      style: textTheme.bodySmall?.copyWith(color: Colors.black),
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
