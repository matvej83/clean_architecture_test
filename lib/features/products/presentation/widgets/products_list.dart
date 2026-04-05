import 'package:clean_architecture_test/core/presentation/widgets/app_dialog.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_event.dart';
import 'package:clean_architecture_test/features/products/presentation/widgets/product_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final bloc = context.read<ProductsBloc>();
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = products[index];
        return Slidable(
          key: ValueKey(item.id),
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            extentRatio: 0.3,
            children: [
              SlidableAction(
                onPressed: (context) async {
                  final result = await AppDialog.show(
                    context,
                    title: 'productScreen.deleteProduct'.tr(),
                    text: 'productScreen.areYouSure'.tr(),
                    cancelText: 'productScreen.cancelText'.tr(),
                    okText: 'productScreen.okText'.tr(),
                  );
                  if (result) {
                    final id = int.tryParse(item.id) ?? 0;
                    bloc.add(ProductDeleted(id: id));
                  }
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete_forever,
                label: 'productScreen.delete'.tr(),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ],
          ),
          child: ProductItem(key: ValueKey(item.id), product: item),
        );
      }, childCount: products.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenSize.width > screenSize.height ? 3 : 1,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1,
      ),
    );
  }
}
