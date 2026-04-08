import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FilterModalHeader extends StatelessWidget {
  const FilterModalHeader({
    super.key,
    required this.canFiltersBeSaved,
    required this.onResetTap,
    required this.onCloseTap,
  });

  final bool canFiltersBeSaved;
  final VoidCallback onResetTap;
  final VoidCallback onCloseTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.0,
          children: [
            Text('filtersModal.modalName'.tr(), style: textTheme.bodyMedium),
            if (canFiltersBeSaved)
              IconButton(
                onPressed: onResetTap,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                ),
                icon: Icon(
                  Icons.filter_alt_off,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
          ],
        ),
        GestureDetector(
          onTap: onCloseTap,
          child: Icon(Icons.close, size: 24, color: Colors.grey),
        ),
      ],
    );
  }
}
