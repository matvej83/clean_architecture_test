import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_event.dart';
import 'package:clean_architecture_test/features/auth/presentation/widgets/user_avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../widgets/language_selector.dart';
import '../widgets/theme_selector.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextTheme textTheme;
  bool _showSelector = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _showSelector = true);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return Center(
            child: Column(
              spacing: 16.0,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserAvatar(avatar: state.user?.avatar ?? ''),
                Text('${state.user?.name}', style: textTheme.headlineSmall),
                Text(
                  '${'loginScreen.fieldNameEmail'.tr()}: ${state.user?.email}',
                  style: textTheme.bodyLarge,
                ),
                Text(
                  '${'profileScreen.role'.tr()}: ${state.user?.role}',
                  style: textTheme.bodyLarge,
                ),
                if (_showSelector) ...[
                  ThemeSelector(),
                  LanguageSelector(),
                ] else
                  SizedBox(),
                Row(
                  spacing: 8.0,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'profileScreen.btnLogout'.tr(),
                      style: textTheme.bodyLarge,
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogoutRequested());
                      },
                      icon: Icon(Icons.logout, size: 28.0, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
