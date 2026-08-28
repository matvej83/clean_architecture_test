import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/features/locations/presentation/pages/locations_page.dart';
import 'package:store_app/features/products/presentation/pages/add_category_page.dart';
import 'package:store_app/features/products/presentation/pages/add_product_page.dart';

import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/presentation/bloc/auth_state.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/splash_page.dart';
import '../features/main/presentation/main_screen.dart';
import '../features/products/presentation/pages/product_page.dart';
import '../features/products/presentation/pages/products_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/users/presentation/pages/user_page.dart';
import '../features/users/presentation/pages/users_page.dart';
import 'pages.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@lazySingleton
class AppRouter {
  AppRouter(this.authBloc);

  final AuthBloc authBloc;

  late final GoRouter router = GoRouter(
    initialLocation: Pages.splash,
    overridePlatformDefaultLocation: false,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final status = authBloc.state.status;

      final isLogin = state.matchedLocation == Pages.login;
      final isSplash = state.matchedLocation == Pages.splash;

      if (status == AuthStatus.unknown) {
        return null;
      }

      if (status == AuthStatus.unauthenticated) {
        return isLogin ? null : Pages.login;
      }

      if (status == AuthStatus.authenticated) {
        if (isSplash || isLogin) {
          return Pages.products;
        }
        return null;
      }

      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell, state: state);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Pages.products,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProductsPage()),
                routes: [
                  GoRoute(
                    path: Pages.addProduct,
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: AddProductPage()),
                  ),
                  GoRoute(
                    path: Pages.addCategory,
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: AddCategoryPage()),
                  ),
                  GoRoute(
                    path: ':id',
                    pageBuilder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return NoTransitionPage(
                        child: ProductPage(key: ValueKey(id), id: id),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Pages.users,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: UsersPage()),
                routes: [
                  GoRoute(
                    path: ':id',
                    pageBuilder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return NoTransitionPage(
                        child: UserPage(key: ValueKey(id), id: id),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Pages.locations,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: LocationsPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Pages.profile,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfilePage()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Pages.splash,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SplashPage()),
      ),
      GoRoute(
        path: Pages.login,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginPage()),
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
