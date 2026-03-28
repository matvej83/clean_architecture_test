import 'package:clean_architecture_test/features/locations/presentation/bloc/locations_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LocationsBloc>().state;

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: state.center,
        initialZoom: 5.0,
        onTap: (tapPosition, latLng) {},
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.vladimir.dev.cleanarchitecturetest',
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
                child: Text(cluster.length.toString()),
              );
            },
          ),
        ),
      ],
    );
  }
}
