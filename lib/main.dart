import 'dart:async';

import 'package:clean_architecture_test/core/presentation/theme/app_theme.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_test/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:clean_architecture_test/features/products/domain/usecases/fetch_categories_usecase.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture_test/navigation/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/di/injection.dart';
import 'core/services/auth_session_manager.dart';
import 'core/services/geolocation_service.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/locations/domain/usecases/fetch_products_usecase.dart';
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
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription _sessionSub;
  final appRouter = getIt<AppRouter>();
  final authBloc = getIt<AuthBloc>();
  final sessionManager = getIt<AuthSessionManager>();
  final authRepo = getIt<AuthRepository>();
  final geolocationService = getIt<GeolocationService>();

  // products
  final fetchProductsUseCase = getIt<FetchProductsUseCase>();
  final fetchProductUseCase = getIt<FetchProductUseCase>();
  final fetchCategoriesUseCase = getIt<FetchCategoriesUseCase>();
  final fetchRelatedByIdUseCase = getIt<FetchRelatedByIdUseCase>();

  // users
  final fetchUsersUseCase = getIt<FetchUsersUseCase>();
  final fetchUserUseCase = getIt<FetchUserUseCase>();

  // locations
  final fetchLocationsUseCase = getIt<FetchLocationsUseCase>();

  @override
  void initState() {
    super.initState();
    sessionManager.setRepository(authRepo);
    _sessionSub = sessionManager.onSessionExpired.listen((_) async {
      await sessionManager.logout();
      appRouter.router.go('/login');
    });
    geolocationService.startTracking();
  }

  @override
  void dispose() {
    _sessionSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        BlocProvider(
          create: (_) => LocationsBloc(
            fetchLocationsUseCase: fetchLocationsUseCase,
            geolocationService: geolocationService,
          ),
          lazy: true,
        ),
      ],
      child: MaterialApp.router(
        title: 'Store App',
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
