import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_state.dart';
import 'package:clean_architecture_test/features/products/presentation/widgets/categories_list.dart';
import 'package:clean_architecture_test/features/products/presentation/widgets/products_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/app_dialog.dart';
import '../bloc/products_event.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bloc = context.read<ProductsBloc>();
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 12.0),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'productsScreen.categories'.tr(),
                        style: textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 12.0),
                    sliver: SliverToBoxAdapter(
                      child: CategoriesList(
                        categories: state.categories,
                        selectedCategoryId: state.selectedCategoryId,
                        onTap: (id) {
                          bloc.add(ProductsFetched(categoryId: id));
                        },
                        onDeleteTap: (id) async {
                          final result = await AppDialog.show(
                            context,
                            title: 'productsScreen.deleteCategory'.tr(),
                            text: 'productsScreen.areYouSureCategory'.tr(),
                            cancelText: 'productsScreen.cancelText'.tr(),
                            okText: 'productsScreen.okText'.tr(),
                          );
                          if (result) {
                            bloc.add(
                              CategoryDeleted(id: int.tryParse(id) ?? 0),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 24.0),
                    sliver: ProductsList(products: state.products),
                  ),
                ],
              );
      },
    );
  }
}
