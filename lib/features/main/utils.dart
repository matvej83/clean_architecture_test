import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/presentation/widgets/fab_menu.dart';
import '../../navigation/pages.dart';

class MainScreenUtils {
  static String getAppBarTitle(BuildContext context) {
    final location = GoRouterState.of(context).uri;
    if (location.pathSegments.length == 2) {
      if (location.pathSegments.first == 'products') {
        if (location.pathSegments.last == Pages.addProduct) {
          return 'addProductScreen.screenName'.tr();
        }
        if (location.pathSegments.last == Pages.addCategory) {
          return 'addCategoryScreen.screenName'.tr();
        }
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

  static Widget? getFAB(
    BuildContext context, {
    required VoidCallback action,
    required GoRouterState state,
  }) {
    final location = state.uri.path;
    return switch (location) {
      Pages.products => FabMenu(
        key: const ValueKey('fab'),
        onAddProductTap: () {
          context.go('${Pages.products}/${Pages.addProduct}');
        },
        onAddCategoryTap: () {
          context.go('${Pages.products}/${Pages.addCategory}');
        },
      ),
      Pages.locations =>
        kIsWeb
            ? FloatingActionButton(
                onPressed: action,
                child: const Icon(Icons.location_searching),
              )
            : null,
      _ => null,
    };
  }
}
