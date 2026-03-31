import 'package:clean_architecture_test/features/theme/cubit/cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/domain/entity/app_theme_mode.dart';

class ThemeSelector extends StatefulWidget {
  const ThemeSelector({super.key});

  @override
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  late ThemeCubit cubit;
  late AppThemeMode dropdownValue;
  late AppThemeMode initialValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = context.read<ThemeCubit>();
    final state = context.watch<ThemeCubit>().state;
    initialValue = state.mode;
    dropdownValue = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      key: ValueKey(context.locale),
      builder: (context) {
        return DropdownMenu<AppThemeMode>(
          initialSelection: initialValue,
          onSelected: (AppThemeMode? value) {
            if (value != null) {
              setState(() {
                dropdownValue = value;
                cubit.changeTheme(value);
              });
            }
          },
          dropdownMenuEntries: <DropdownMenuEntry<AppThemeMode>>[
            DropdownMenuEntry<AppThemeMode>(
              value: AppThemeMode.dark,
              label: 'profileScreen.themeDark'.tr(),
            ),
            DropdownMenuEntry<AppThemeMode>(
              value: AppThemeMode.light,
              label: 'profileScreen.themeLight'.tr(),
            ),
          ],
        );
      },
    );
  }
}
