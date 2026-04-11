import 'package:clean_architecture_test/core/domain/entity/avaliability_filter_entity.dart';
import 'package:clean_architecture_test/core/presentation/theme/app_colors.dart';
import 'package:clean_architecture_test/core/presentation/widgets/app_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AmountFilterBlock extends StatelessWidget {
  const AmountFilterBlock({
    super.key,
    required this.availabilityFilters,
    required this.onRemoveAmountFilters,
    required this.amountMinController,
    required this.amountMaxController,
    required this.amountError,
    this.amountMinError,
    this.amountMaxError,
  });

  final List<AvailabilityFilterEntity> availabilityFilters;
  final VoidCallback onRemoveAmountFilters;
  final TextEditingController amountMinController;
  final TextEditingController amountMaxController;
  final ValueNotifier<String> amountError;
  final String? amountMinError;
  final String? amountMaxError;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'filtersModal.amount'.tr(),
              style: textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
            if (availabilityFilters.any((e) => e.groupName == 'amounts'))
              SizedBox(
                width: 21.0,
                height: 21.0,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: onRemoveAmountFilters,
                  icon: Icon(
                    Icons.indeterminate_check_box,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
          ],
        ),
        Column(
          spacing: 6,
          children: [
            Row(
              spacing: 12.0,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      Text(
                        '${'filtersModal.from'.tr()}:',
                        style: textTheme.bodyMedium,
                      ),
                      AppTextFormField(
                        controller: amountMinController,
                        keyboardType: TextInputType.number,
                        unfocusOnTapOutside: false,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      Text(
                        '${'filtersModal.to'.tr()}:',
                        style: textTheme.bodyMedium,
                      ),
                      AppTextFormField(
                        controller: amountMaxController,
                        keyboardType: TextInputType.number,
                        unfocusOnTapOutside: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ValueListenableBuilder<String>(
              valueListenable: amountError,
              builder: (context, value, child) {
                return value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          value,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      )
                    : SizedBox();
              },
            ),
          ],
        ),
      ],
    );
  }
}
