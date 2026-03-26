import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_state.dart';
import 'package:clean_architecture_test/features/products/presentation/widgets/categories_list.dart';
import 'package:clean_architecture_test/features/products/presentation/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: CategoriesList()),
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
