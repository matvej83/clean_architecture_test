import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductsBloc>().state;
    return SizedBox(
      height: 170.0,
      child: ListView.separated(
        itemCount: state.categories.length,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final category = state.categories[index];
          final isSelected = state.selectedCategoryId == category.id;
          return ListItem(
            key: ValueKey(category.id),
            isSelected: isSelected,
            onTap: () {
              context.read<ProductsBloc>().add(
                ProductsFetched(categoryId: isSelected ? '' : category.id),
              );
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
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isSelected ? Colors.white24 : null,
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
              style: textTheme.bodyMedium?.copyWith(
                color: isSelected ? Colors.blue : null,
              ),
              softWrap: true,
              overflow: TextOverflow.fade,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
