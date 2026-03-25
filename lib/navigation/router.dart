import 'dart:async';

import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_state.dart';
import 'package:clean_architecture_test/features/main/presentation/pages/profile_page.dart';
import 'package:clean_architecture_test/features/products/presentation/pages/products_page.dart';
import 'package:clean_architecture_test/navigation/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/splash_page.dart';
import '../features/main/presentation/main_screen.dart';
import '../features/main/presentation/pages/home_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  late final GoRouter router = GoRouter(
    initialLocation: Pages.splash,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final status = authBloc.state.status;

      final isLogin = state.matchedLocation == Pages.login;
      final isSplash = state.matchedLocation == Pages.splash;

      if (status == AuthStatus.unknown) {
        return isSplash ? null : Pages.splash;
      }

      if (status == AuthStatus.unauthenticated) {
        return isLogin ? null : Pages.login;
      }

      if (status == AuthStatus.authenticated) {
        if (isSplash || isLogin) return Pages.products;
        return null;
      }

      return null;
    },
    routes: [
      /// Shell routes
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainScreen();
        },
        routes: [
          GoRoute(
            path: Pages.main,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomePage()),
          ),
          GoRoute(
            path: Pages.products,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProductsPage()),
          ),
          GoRoute(
            path: Pages.profile,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfilePage()),
          ),
        ],
      ),

      /// routes
      GoRoute(
        path: Pages.splash,
        builder: (context, state) {
          return SplashPage();
        },
      ),
      GoRoute(
        path: Pages.login,
        builder: (context, state) {
          return LoginPage();
        },
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  final Stream<dynamic> _stream;
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(this._stream) {
    _subscription = _stream.listen((event) {
      return notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
