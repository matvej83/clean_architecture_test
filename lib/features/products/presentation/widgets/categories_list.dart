import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/image_box.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onTap,
    this.onDeleteTap,
  });

  final List<CategoryEntity> categories;
  final String selectedCategoryId;
  final Function(CategoryEntity) onTap;
  final Function(String)? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: ListView.separated(
          itemCount: categories.length,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = selectedCategoryId == category.id;
            return ListItem(
              key: ValueKey(category.id),
              isSelected: isSelected,
              onTap: () {
                onTap(category);
              },
              onDeleteTap: () {
                onDeleteTap?.call(category.id);
              },
              category: category,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 8.0),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.category,
    this.isSelected = false,
    required this.onTap,
    this.onDeleteTap,
  });

  final CategoryEntity category;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onDeleteTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: isSelected ? BorderRadius.circular(8.0) : null,
          color: isSelected ? theme.unselectedWidgetColor : null,
        ),
        width: 120.0,
        child: Column(
          spacing: 8.0,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                height: 104.0,
                child: ImageBox(imageUrl: category.image, fit: BoxFit.fill),
              ),
            ),
            Text(
              category.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? theme.colorScheme.primary : null,
              ),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
