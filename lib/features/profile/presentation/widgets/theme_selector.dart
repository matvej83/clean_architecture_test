import 'package:clean_architecture_test/core/presentation/widgets/custom_dropdown_menu.dart';
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
  late AppThemeMode initialValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = context.read<ThemeCubit>();
    final state = context.watch<ThemeCubit>().state;
    initialValue = state.mode;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu<AppThemeMode>(
      key: ValueKey(context.locale),
      initialValue: initialValue,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            cubit.changeTheme(value);
          });
        }
      },
      entries: <DropdownMenuEntry<AppThemeMode>>[
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
  }
}
