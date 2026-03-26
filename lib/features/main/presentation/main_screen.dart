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
  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    switch (location) {
      case Pages.products:
        return 0;
      case Pages.users:
        return 1;
      case Pages.profile:
        return 2;
    }
    return 0;
  }

  void _onItemTap(BuildContext context, {index}) {
    switch (index) {
      case 0:
        context.go(Pages.products);
        break;
      case 1:
        context.go(Pages.users);
        break;
      case 2:
        context.go(Pages.profile);
        break;
    }
  }

  String _getAppBarTitle(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.contains('products/')) {
      return 'Product';
    }
    if (location.contains('users/')) {
      return 'User';
    }
    switch (location) {
      case Pages.products:
        return 'Products';
      case Pages.users:
        return 'Users';
      case Pages.profile:
        return 'Profile';
    }
    return 'Home';
  }

  bool showBackButton(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return switch (location) {
      Pages.products || Pages.users || Pages.profile => false,
      _ => true,
    };
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(_getAppBarTitle(context)),
        centerTitle: true,
        leading: showBackButton(context)
            ? BackButton(
                onPressed: () {
                  context.pop();
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
        currentPage: _getCurrentIndex(context),
        onItemTap: (index) {
          _onItemTap(context, index: index);
        },
      ),
    );
  }
}
