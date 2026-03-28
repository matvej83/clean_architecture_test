import 'package:clean_architecture_test/core/presentation/theme/app_theme.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_test/features/products/domain/usecases/fetch_categories_usecase.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture_test/navigation/router.dart';
import 'package:easy_localization/easy_localization.dart';
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
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await configureDependencies();
  final sessionManager = getIt<AuthSessionManager>();
  sessionManager.onLogout = () {
    getIt<AuthBloc>().add(AuthLogoutRequested());
  };
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp(),
    ),
  );
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
    final appRouter = getIt<AppRouter>();

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
        theme: AppTheme.dark,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
