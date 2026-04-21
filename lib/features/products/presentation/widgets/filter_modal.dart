import 'package:clean_architecture_test/core/constants/app_strings.dart';
import 'package:clean_architecture_test/core/domain/entity/avaliability_filter_entity.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_event.dart';
import 'package:clean_architecture_test/features/products/presentation/widgets/selected_filters_block.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/products_state.dart';
import 'amount_filter_block.dart';
import 'filter_modal_header.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  bool isDataInitialized = false;
  bool isInitializing = false;
  late ProductsBloc bloc;
  late ProductsState state;
  final amountsGroupName = AppStrings.amountsGroupName;
  final amountMax = AppStrings.amountMax;
  final amountMin = AppStrings.amountMin;

  // filters
  List<AvailabilityFilterEntity> availabilityFilters = [];

  // errors and validation
  final amountError = ValueNotifier<String>('');
  final amountMinController = TextEditingController();
  final amountMaxController = TextEditingController();
  String? amountMinError;
  String? amountMaxError;

  void initFilters(List<AvailabilityFilterEntity> filters) {
    isInitializing = true;
    if (filters.isNotEmpty) {
      availabilityFilters = List.from(filters);
      if (availabilityFilters.any((e) => e.groupName == amountsGroupName)) {
        amountMinController.text =
            availabilityFilters
                .firstWhereOrNull((e) => e.identifier == amountMin)
                ?.apiValue
                ?.toString() ??
            '';
        amountMaxController.text =
            availabilityFilters
                .firstWhereOrNull((e) => e.identifier == amountMax)
                ?.apiValue
                ?.toString() ??
            '';
      }
    }
    isDataInitialized = true;
    isInitializing = false;
  }

  void saveFilters() {
    bloc.add(FiltersSaved(filters: availabilityFilters));
  }

  void addFilter(AvailabilityFilterEntity filter) {
    availabilityFilters.add(filter);
  }

  void removeFilter(AvailabilityFilterEntity filter) {
    availabilityFilters.removeWhere((e) => e.identifier == filter.identifier);
    onFilterRemoved(filter);
  }

  void removeFilterByGroupName(String groupName) {
    availabilityFilters.removeWhere((e) => e.groupName == groupName);
  }

  void onFilterRemoved(AvailabilityFilterEntity filter) {
    final identifier = filter.identifier;
    switch (identifier) {
      case AppStrings.amountMin:
        amountMinController.text = '';
        break;
      case AppStrings.amountMax:
        amountMaxController.text = '';
        break;
    }
  }

  void _validatePrice() {
    if (isInitializing) {
      return;
    }
    final min = amountMinController.text;
    final max = amountMaxController.text;
    if (max.isNotEmpty) {
      amountMaxError = (double.tryParse(min) ?? 0) > (double.tryParse(max) ?? 0)
          ? 'fieldValidation.maxAmount'.tr()
          : null;
    } else {
      amountMaxError = null;
    }
    amountError.value = amountMinError ?? amountMaxError ?? '';
    if (amountMinError == null && amountMaxError == null) {
      availabilityFilters.removeWhere((e) => e.groupName == amountsGroupName);
      if (min.isNotEmpty) {
        addFilter(
          AvailabilityFilterEntity(
            groupName: amountsGroupName,
            displayName: '${'filtersModal.from'.tr()}: \$$min',
            value: '',
            apiValue: int.tryParse(min),
            identifier: amountMin,
          ),
        );
      } else {
        availabilityFilters.removeWhere((e) => e.identifier == amountMin);
      }
      if (max.isNotEmpty) {
        addFilter(
          AvailabilityFilterEntity(
            groupName: amountsGroupName,
            displayName: '${'filtersModal.to'.tr()}: \$$max',
            value: '',
            apiValue: int.tryParse(max),
            identifier: amountMax,
          ),
        );
      } else {
        availabilityFilters.removeWhere((e) => e.identifier == amountMax);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    amountMinController.addListener(_validatePrice);
    amountMaxController.addListener(_validatePrice);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    bloc = context.read<ProductsBloc>();
    state = context.watch<ProductsBloc>().state;
    if (!isDataInitialized) {
      initFilters(state.filters);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    amountMinController.dispose();
    amountMaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        final wasFiltersChanged = !listEquals(
          state.filters,
          availabilityFilters,
        );
        return Container(
          constraints: BoxConstraints(maxHeight: screenHeight - 32.0),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              FilterModalHeader(
                canFiltersBeSaved:
                    availabilityFilters.isNotEmpty || wasFiltersChanged,
                onResetTap: () {
                  availabilityFilters.clear();
                  amountMinController.text = '';
                  amountMaxController.text = '';
                  setState(() {});
                },
                onCloseTap: () {
                  context.pop();
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SelectedFiltersBlock(
                  selectedFilters: availabilityFilters,
                  onFilterRemove: (filter) {
                    removeFilter(filter);
                    setState(() {});
                  },
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    spacing: 16.0,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AmountFilterBlock(
                        availabilityFilters: availabilityFilters,
                        onRemoveAmountFilters: () {
                          removeFilterByGroupName(amountsGroupName);
                          amountMinController.text = '';
                          amountMaxController.text = '';
                          setState(() {});
                        },
                        amountMinController: amountMinController,
                        amountMaxController: amountMaxController,
                        amountError: amountError,
                      ),
                      ElevatedButton(
                        onPressed: wasFiltersChanged
                            ? () {
                                context.pop();
                                saveFilters();
                              }
                            : null,
                        child: Text('filtersModal.btnConfirm'.tr()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
