import 'package:clean_architecture_test/features/main/presentation/pages/home_page.dart';
import 'package:clean_architecture_test/features/main/presentation/pages/profile_page.dart';
import 'package:clean_architecture_test/features/main/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../navigation/pages.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// Using IndexedStack to prevent rebuilds
  final Map<int, Widget> _screens = {
    0: const HomePage(),
    1: const ProfilePage(),
  };

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    switch (location) {
      case Pages.main:
        return 0;
      case Pages.profile:
        return 1;
    }
    return 0;
  }

  void _onItemTap(BuildContext context, {index}) {
    switch (index) {
      case 0:
        context.go(Pages.main);
        break;
      case 1:
        context.go(Pages.profile);
        break;
    }
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 1:
        return 'Home';
      case 2:
        return 'Profile';
    }
    return 'Home';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(_getAppBarTitle(_getCurrentIndex(context))),
        centerTitle: true,
      ),
      body: SafeArea(
        left: true,
        right: true,
        minimum: const EdgeInsets.only(left: 10, right: 10),
        child: IndexedStack(
          index: _getCurrentIndex(context),
          children: _screens.values.toList(),
        ),
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
