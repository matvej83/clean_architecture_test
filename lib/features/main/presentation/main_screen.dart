import 'package:clean_architecture_test/core/presentation/widgets/fab_menu.dart';
import 'package:clean_architecture_test/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:clean_architecture_test/features/locations/presentation/bloc/locations_event.dart';
import 'package:clean_architecture_test/features/main/presentation/widgets/bottom_nav_bar.dart';
import 'package:clean_architecture_test/features/main/utils.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/services/geolocation_service.dart';
import '../../../navigation/pages.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ProductsBloc productsBloc;
  late LocationsBloc locationsBloc;
  final geolocationService = getIt<GeolocationService>();

  @override
  void initState() {
    productsBloc = context.read<ProductsBloc>();
    locationsBloc = context.read<LocationsBloc>();
    productsBloc.add(const ProductsFetched(loadSilent: false));
    productsBloc.add(const CategoriesFetched());
    locationsBloc.add(const LocationsFetched(loadSilent: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MainScreenUtils.getAppBarTitle(context)),
        centerTitle: true,
        leading: MainScreenUtils.showBackButton(context)
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
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: widget.navigationShell.currentIndex == 0
            ? FabMenu(
                key: const ValueKey('fab'),
                onAddProductTap: () {
                  context.push(Pages.addProduct);
                },
                onAddCategoryTap: () {
                  context.push(Pages.addCategory);
                },
              )
            : widget.navigationShell.currentIndex == 2 && kIsWeb
            ? FloatingActionButton(
                child: const Icon(Icons.location_searching),
                onPressed: () async {
                  final granted = await geolocationService.requestPermission();
                  if (granted) {
                    await geolocationService.startTracking();
                    locationsBloc.add(const LocationsFetched());
                  }
                },
              )
            : null,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavBar(
        currentPage: widget.navigationShell.currentIndex,
        onItemTap: (index) {
          widget.navigationShell.goBranch(index);
        },
      ),
    );
  }
}
