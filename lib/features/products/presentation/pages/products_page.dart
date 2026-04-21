import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_state.dart';
import 'package:clean_architecture_test/features/products/presentation/widgets/categories_list.dart';
import 'package:clean_architecture_test/features/products/presentation/widgets/filter_modal.dart';
import 'package:clean_architecture_test/features/products/presentation/widgets/products_list.dart';
import 'package:clean_architecture_test/features/products/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/app_dialog.dart';
import '../../../../core/presentation/widgets/availability_filters_list.dart';
import '../bloc/products_event.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late ProductsBloc bloc;
  final _scrollController = ScrollController();

  void _onScroll() {
    if (ProductsUtils.isBottom(_scrollController)) {
      bloc.add(const NextProductsFetched());
    }
  }

  @override
  void initState() {
    super.initState();
    bloc = context.read<ProductsBloc>();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 12.0, right: 16.0),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          spacing: 8.0,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 40.0,
                                child: SearchBar(
                                  leading: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  onTapOutside: (PointerDownEvent event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  onChanged: (search) {
                                    bloc.add(
                                      ProductsSearchStarted(search: search),
                                    );
                                  },
                                ),
                              ),
                            ),
                            ProductsUtils.getFilterButton(
                              context,
                              isActive: state.filters.isNotEmpty,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const Material(
                                    color: Colors.transparent,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                        ),
                                        child: FilterModal(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
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
                          onTap: (category) {
                            final isSelected =
                                category.id == state.selectedCategoryId;
                            bloc.add(
                              ProductsCategorySelected(
                                categoryId: isSelected ? '' : category.id,
                              ),
                            );
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
                    if (state.filters.isNotEmpty == true)
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 24.0),
                        sliver: SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AvailabilityFiltersList(
                                availabilityFilters: state.filters,
                                onTap: (filter) {
                                  bloc.add(FilterRemoved(filter: filter));
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 24.0, right: 16.0),
                      sliver: ProductsList(products: state.products),
                    ),
                    if (state.isShowProductLoader)
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              );
      },
    );
  }
}
