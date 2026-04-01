import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/pages.dart';

class MainScreenUtils {
  static String getAppBarTitle(BuildContext context) {
    final location = GoRouterState.of(context).uri;
    if (location.pathSegments.length == 2) {
      if (location.pathSegments.first == 'products') {
        return 'productScreen.screenName'.tr();
      } else if (location.pathSegments.first == 'users') {
        return 'userScreen.screenName'.tr();
      }
    }
    return switch (location.toString()) {
      Pages.products => 'productsScreen.screenName'.tr(),
      Pages.users => 'usersScreen.screenName'.tr(),
      Pages.locations => 'locationsScreen.screenName'.tr(),
      Pages.profile => 'profileScreen.screenName'.tr(),
      _ => '',
    };
  }

  static bool showBackButton(BuildContext context) {
    final uri = GoRouterState.of(context).uri;
    return uri.pathSegments.length > 1;
  }
}
