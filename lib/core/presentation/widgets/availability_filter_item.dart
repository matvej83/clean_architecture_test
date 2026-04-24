import 'package:clean_architecture_test/core/domain/entity/availability_filter_entity.dart';
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
    final isDark = theme.brightness == Brightness.dark;
    final defaultBackgroundColor = isDark
        ? Colors.grey.shade600
        : Colors.grey.shade400;
    return Container(
      constraints: const BoxConstraints(maxWidth: 120.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: backgroundColor ?? defaultBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Row(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              filter.value.isNotEmpty
                  ? '${filter.displayName} (${filter.value})'
                  : filter.displayName,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.white : Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.close, size: 16.0),
        ],
      ),
    );
  }
}
