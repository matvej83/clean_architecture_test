import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return GridView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenSize.width > screenSize.height ? 3 : 1,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final item = products[index];
        return ListItem(key: ValueKey(item.id), product: item);
      },
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      spacing: 8.0,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Image.network(
            product.images.first,
            errorBuilder: (context, o, s) => Container(color: Colors.white24),
          ),
        ),
        Text('\$${product.price}', style: textTheme.bodyMedium),
        Text('\$${product.title}', style: textTheme.bodyLarge),
      ],
    );
  }
}
