import 'package:clean_architecture_test/features/locations/domain/entity/location_entity.dart';
import 'package:clean_architecture_test/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:clean_architecture_test/features/locations/presentation/bloc/locations_event.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationsList extends StatelessWidget {
  const LocationsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LocationsBloc>();
    final state = context.watch<LocationsBloc>().state;
    return ListView.separated(
      itemCount: state.locations.length,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 16.0),
      itemBuilder: (context, index) {
        final location = state.locations[index];
        final isSelected = location.id == state.selectedLocationId;
        return ListItem(
          key: ValueKey(location.id),
          isSelected: isSelected,
          onTap: () {
            if (isSelected) {
              bloc.add(LocationSelected(locationId: ''));
            } else {
              bloc.add(
                LocationSelected(locationId: location.id, location: location),
              );
            }
          },
          location: location,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.location,
    this.isSelected = false,
    required this.onTap,
  });

  final LocationEntity location;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: isSelected
              ? Border.all(color: Theme.of(context).primaryColor)
              : Border.all(color: Theme.of(context).unselectedWidgetColor),
          color: isSelected ? Theme.of(context).unselectedWidgetColor : null,
        ),
        child: Column(
          spacing: 8.0,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location.name, style: textTheme.titleMedium, softWrap: true),
            Text(
              location.description,
              style: textTheme.bodyMedium,
              softWrap: true,
            ),
            Text(
              '${'locationsScreen.latitude'.tr()} ${location.latitude},',
              style: textTheme.bodyMedium,
              softWrap: true,
            ),
            Text(
              '${'locationsScreen.longitude'.tr()} ${location.longitude}',
              style: textTheme.bodyMedium,
              softWrap: true,
            ),
            if (location.distance != null)
              Text(
                '${location.distance} km from you',
                style: textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}
