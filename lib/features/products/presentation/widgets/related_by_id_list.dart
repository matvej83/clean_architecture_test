import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../navigation/pages.dart';
import '../../domain/entity/product_entity.dart';
import '../bloc/products_bloc.dart';

class RelatedByIdList extends StatelessWidget {
  const RelatedByIdList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductsBloc>().state;
    return SizedBox(
      height: 200.0,
      child: ListView.separated(
        itemCount: state.relatedById.length,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final product = state.relatedById[index];
          return ListItem(key: ValueKey(product.id), product: product);
        },
        separatorBuilder: (context, index) => SizedBox(width: 8.0),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        context.go(Pages.product + product.id);
      },
      child: SizedBox(
        width: 130.0,
        child: Column(
          spacing: 8.0,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 120.0,
              child: Image.network(
                product.images.first,
                errorBuilder: (context, o, s) =>
                    Container(height: 120.0, color: Colors.white24),
              ),
            ),
            Text('\$${product.price}', style: textTheme.bodyMedium),
            Text(
              product.title,
              style: textTheme.bodyLarge,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
