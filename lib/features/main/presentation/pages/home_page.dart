import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                Icon(Icons.home_filled, size: 40.0, color: Colors.green),
                Text(
                  'Welcome',
                  style: TextStyle(fontSize: 20.0, color: Colors.blue),
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
