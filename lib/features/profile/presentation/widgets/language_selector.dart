import 'package:clean_architecture_test/features/profile/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late String dropdownValue;
  late String initialValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initialValue = context.locale.languageCode;
    dropdownValue = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: initialValue,
      leadingIcon: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: ProfileUtils.getLanguageIcon(dropdownValue),
      ),
      onSelected: (String? value) {
        if (value != null) {
          setState(() {
            dropdownValue = value;
            context.setLocale(Locale(value));
          });
        }
      },
      dropdownMenuEntries: <DropdownMenuEntry<String>>[
        DropdownMenuEntry<String>(
          value: 'en',
          label: 'profileScreen.langEn'.tr(),
          leadingIcon: ProfileUtils.getLanguageIcon('en'),
        ),
        DropdownMenuEntry<String>(
          value: 'ru',
          label: 'profileScreen.langRu'.tr(),
          leadingIcon: ProfileUtils.getLanguageIcon('ru'),
        ),
      ],
    );
  }
}
