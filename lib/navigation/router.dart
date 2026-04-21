import 'dart:async';

import 'package:clean_architecture_test/features/locations/presentation/pages/locations_page.dart';
import 'package:clean_architecture_test/features/products/presentation/pages/add_category_page.dart';
import 'package:clean_architecture_test/features/products/presentation/pages/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

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

  bool _isFirstNavigation = true;

  late final GoRouter router = GoRouter(
    initialLocation: Pages.splash,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final status = authBloc.state.status;

      final isPublic = isPublicRoute(state);
      final isLogin = state.matchedLocation == Pages.login;
      final isSplash = state.matchedLocation == Pages.splash;

      final isDeepLink =
          _isFirstNavigation && state.uri.toString() != Pages.splash;

      // disable flag
      _isFirstNavigation = false;

      // --- SPLASH ---
      if (status == AuthStatus.unknown) {
        return isSplash ? null : Pages.splash;
      }

      // --- UNAUTH ---
      if (status == AuthStatus.unauthenticated) {
        if (isPublic || isLogin) return null;

        // save <from> only for deeplink
        if (isDeepLink) {
          final from = state.uri.toString();
          return '${Pages.login}?from=$from';
        }

        return Pages.login;
      }

      // --- AUTH ---
      if (status == AuthStatus.authenticated) {
        if (isSplash || isLogin) {
          final from = state.uri.queryParameters['from'];
          return from ?? Pages.products;
        }
        return null;
      }

      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell);
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
                    path: ':id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return ProductPage(key: ValueKey(id), id: id);
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
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return UserPage(key: ValueKey(id), id: id);
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
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: Pages.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Pages.addProduct,
        builder: (context, state) => const AddProductPage(),
      ),
      GoRoute(
        path: Pages.addCategory,
        builder: (context, state) => const AddCategoryPage(),
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

bool isPublicRoute(GoRouterState state) {
  return [Pages.login].contains(state.matchedLocation);
}
