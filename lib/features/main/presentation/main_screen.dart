import 'package:clean_architecture_test/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:clean_architecture_test/features/locations/presentation/bloc/locations_event.dart';
import 'package:clean_architecture_test/features/main/presentation/widgets/bottom_nav_bar.dart';
import 'package:clean_architecture_test/features/main/utils.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    context.read<ProductsBloc>().add(ProductsFetched(loadSilent: false));
    context.read<ProductsBloc>().add(CategoriesFetched());
    context.read<LocationsBloc>().add(LocationsFetched(loadSilent: false));
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
      bottomNavigationBar: BottomNavBar(
        currentPage: widget.navigationShell.currentIndex,
        onItemTap: (index) {
          widget.navigationShell.goBranch(index);
        },
      ),
    );
  }
}
