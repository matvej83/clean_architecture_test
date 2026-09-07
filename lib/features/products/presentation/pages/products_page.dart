import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/presentation/widgets/app_loader.dart';
import 'package:store_app/core/presentation/widgets/no_items_widget.dart';
import 'package:store_app/core/presentation/widgets/scroll_up_wrapper.dart';
import 'package:store_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:store_app/features/products/presentation/bloc/products_state.dart';
import 'package:store_app/features/products/presentation/widgets/categories_list.dart';
import 'package:store_app/features/products/presentation/widgets/category_search.dart';
import 'package:store_app/features/products/presentation/widgets/filter_modal.dart';
import 'package:store_app/features/products/presentation/widgets/products_list.dart';
import 'package:store_app/features/products/utils.dart';

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
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        final isLoading = state.isCategoriesLoading || state.isProductLoading;
        return isLoading
            ? const AppLoader()
            : ScrollUpWrapper(
                controller: _scrollController,
                child: Padding(
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
                                    leading: Icon(
                                      Icons.search,
                                      color: theme.colorScheme.onPrimary,
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
                                    fullscreenDialog: true,
                                    builder: (context) => const Scaffold(
                                      backgroundColor: Colors.transparent,
                                      resizeToAvoidBottomInset: true,
                                      body: Center(
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
                          child: CategorySearch(
                            title: 'productsScreen.categories'.tr(),
                            onSearchStarted: (search) {
                              bloc.add(CategorySearchStarted(search: search));
                            },
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 12.0),
                        sliver: SliverToBoxAdapter(
                          child: CategoriesList(
                            categories: state.searchCategory?.isNotEmpty == true
                                ? state.categorySearchResults
                                : state.categories,
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
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
                      // Show empty state when there are no products and not loading
                      if (state.products.isEmpty && !isLoading)
                        const SliverFillRemaining(
                          hasScrollBody: false,
                          child: NoItemsWidget(),
                        ),
                      if (state.isShowProductLoader)
                        const SliverPadding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          sliver: SliverToBoxAdapter(
                            child: Center(
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
