import 'package:clean_architecture_test/core/domain/entity/avaliability_filter_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/availability_filters_list.dart';

class SelectedFiltersBlock extends StatelessWidget {
  const SelectedFiltersBlock({
    super.key,
    required this.selectedFilters,
    required this.onFilterRemove,
  });

  final List<AvailabilityFilterEntity> selectedFilters;
  final Function(AvailabilityFilterEntity) onFilterRemove;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      child: selectedFilters.isNotEmpty
          ? Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AvailabilityFiltersList(
                    key: ValueKey(selectedFilters.length),
                    availabilityFilters: selectedFilters,
                    onTap: onFilterRemove,
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
