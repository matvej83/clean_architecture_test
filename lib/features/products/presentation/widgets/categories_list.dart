import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onTap,
  });

  final List<CategoryEntity> categories;
  final String selectedCategoryId;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
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
              onTap(isSelected ? '' : category.id);
            },
            category: category,
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 8.0),
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
  });

  final CategoryEntity category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
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
              child: Image.network(
                category.image,
                height: 104.0,
                fit: BoxFit.fill,
                errorBuilder: (context, o, s) => Container(
                  height: 104.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: theme.unselectedWidgetColor,
                  ),
                ),
              ),
            ),
            Text(
              category.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? theme.primaryColor : null,
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
