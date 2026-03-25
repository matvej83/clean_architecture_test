import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_test/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthBloc>();
    final appRouter = AppRouter(authBloc: authBloc);

    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: MaterialApp.router(
        title: 'Auth Clean App',
        routerConfig: appRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              disabledBackgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
