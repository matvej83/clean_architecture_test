import 'package:clean_architecture_test/features/main/presentation/widgets/bottom_nav_bar.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../navigation/pages.dart';

class MainScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _getAppBarTitle(BuildContext context) {
    final location = GoRouterState.of(context).uri;
    if (location.pathSegments.length == 2) {
      if (location.pathSegments.first == 'products') {
        return 'Product';
      } else if (location.pathSegments.first == 'users') {
        return 'User';
      }
    }
    return switch (location.toString()) {
      Pages.products => 'Products',
      Pages.users => 'Users',
      Pages.profile => 'Profile',
      _ => 'Home',
    };
  }

  bool showBackButton(BuildContext context) {
    final uri = GoRouterState.of(context).uri;
    return uri.pathSegments.length > 1;
  }

  @override
  void initState() {
    context.read<ProductsBloc>().add(ProductsFetched(loadSilent: false));
    context.read<ProductsBloc>().add(CategoriesFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(context)),
        centerTitle: true,
        leading: showBackButton(context)
            ? BackButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
              )
            : null,
      ),
      body: SafeArea(
        left: true,
        right: true,
        minimum: const EdgeInsets.only(left: 10, right: 10),
        child: widget.navigationShell,
      ),
      bottomNavigationBar: BottomNavBar(
        currentPage: widget.navigationShell.currentIndex,
        onItemTap: (index) {
          widget.navigationShell.goBranch(index);
        },
      ),
    );
  }
}
