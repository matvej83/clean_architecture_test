import 'package:clean_architecture_test/core/domain/entity/avaliability_filter_entity.dart';
import 'package:flutter/material.dart';

class AvailabilityFilterItem extends StatelessWidget {
  const AvailabilityFilterItem({
    super.key,
    required this.filter,
    this.backgroundColor,
  });

  final AvailabilityFilterEntity filter;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: BoxConstraints(maxWidth: 120.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor ?? theme.scaffoldBackgroundColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              filter.value.isNotEmpty
                  ? '${filter.displayName} (${filter.value})'
                  : filter.displayName,
              style: theme.textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(Icons.close, size: 16.0),
        ],
      ),
    );
  }
}
