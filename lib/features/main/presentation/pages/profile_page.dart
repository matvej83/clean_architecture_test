import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return Center(
            child: Column(
              spacing: 16.0,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 40.0,
                  color: Colors.green,
                ),
                Text('email: ${state.user?.email}'),
                Text('name: ${state.user?.name}'),
                IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  },
                  icon: Icon(Icons.logout),
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
