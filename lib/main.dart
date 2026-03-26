import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_test/features/products/domain/usecases/fetch_categories_usecase.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture_test/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/di/injection.dart';
import 'core/services/auth_session_manager.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/products/domain/usecases/fetch_product_usecase.dart';
import 'features/products/domain/usecases/fetch_products_usecase.dart';
import 'features/products/domain/usecases/fetch_related_by_id_usecase.dart';
import 'features/products/presentation/bloc/products_bloc.dart';
import 'features/users/domain/usecases/fetch_user_usecase.dart';
import 'features/users/domain/usecases/fetch_users_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await configureDependencies();
  final sessionManager = getIt<AuthSessionManager>();
  sessionManager.onLogout = () {
    getIt<AuthBloc>().add(AuthLogoutRequested());
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthBloc>();
    final fetchProductsUseCase = getIt<FetchProductsUseCase>();
    final fetchProductUseCase = getIt<FetchProductUseCase>();
    final fetchCategoriesUseCase = getIt<FetchCategoriesUseCase>();
    final fetchRelatedByIdUseCase = getIt<FetchRelatedByIdUseCase>();
    final fetchUsersUseCase = getIt<FetchUsersUseCase>();
    final fetchUserUseCase = getIt<FetchUserUseCase>();
    final appRouter = AppRouter(authBloc: authBloc);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => authBloc),
        BlocProvider(
          create: (_) => ProductsBloc(
            fetchProductsUseCase: fetchProductsUseCase,
            fetchProductUseCase: fetchProductUseCase,
            fetchCategoriesUseCase: fetchCategoriesUseCase,
            fetchRelatedByIdUseCase: fetchRelatedByIdUseCase,
          ),
          lazy: true,
        ),
        BlocProvider(
          create: (_) => UsersBloc(
            fetchUsersUseCase: fetchUsersUseCase,
            fetchUserUseCase: fetchUserUseCase,
          ),
          lazy: true,
        ),
      ],
      child: MaterialApp.router(
        title: 'Auth Clean App',
        routerConfig: appRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Colors.black,
          canvasColor: Colors.black,
          appBarTheme: AppBarTheme(
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0.0,
          ),
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
