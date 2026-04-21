import 'package:clean_architecture_test/features/products/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/products_bloc.dart';

class RelatedByIdList extends StatelessWidget {
  const RelatedByIdList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductsBloc>().state;
    return SizedBox(
      height: 240.0,
      child: ListView.separated(
        itemCount: state.relatedById.length,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final product = state.relatedById[index];
          return ProductItem(key: ValueKey(product.id), product: product);
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8.0),
      ),
    );
  }
}
