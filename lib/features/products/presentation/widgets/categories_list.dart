import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key, required this.categories});

  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.0,
      child: GestureDetector(
        onHorizontalDragUpdate: (_) {},
        child: ListView.separated(
          itemCount: categories.length,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ListItem(key: ValueKey(category.id), category: category);
          },
          separatorBuilder: (context, index) => SizedBox(width: 8.0),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.category});

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 120.0,
      child: Column(
        spacing: 8.0,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            category.image,
            errorBuilder: (context, o, s) =>
                Container(height: 120.0, color: Colors.white24),
          ),
          Text(
            category.name,
            style: textTheme.bodyMedium,
            softWrap: true,
            overflow: TextOverflow.fade,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
