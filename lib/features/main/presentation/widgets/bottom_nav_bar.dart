import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentPage,
    required this.onItemTap,
  });

  final int currentPage;
  final Function(int index) onItemTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentPage,
      onTap: onItemTap,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_filled),
          label: 'bottomNavBar.homeTab'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'bottomNavBar.usersTab'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.place_rounded),
          label: 'bottomNavBar.locationsTab'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'bottomNavBar.profileTab'.tr(),
        ),
      ],
    );
  }
}
