import 'package:clean_architecture_test/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:clean_architecture_test/features/locations/presentation/bloc/locations_state.dart';
import 'package:clean_architecture_test/features/locations/presentation/widgets/locations_list.dart';
import 'package:clean_architecture_test/features/locations/presentation/widgets/map.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/presentation/widgets/app_dialog.dart';
import '../../../../core/presentation/widgets/custom_tab_bar.dart';
import '../bloc/locations_event.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late LocationsBloc bloc;
  int? initialIndex;
  int _currentIndex = 0;
  final int tabCount = 2;

  /// Initialized tabs
  final Map<int, Widget> _builtTabs = {};

  Widget _buildTab(int index) {
    /// return if already exist
    if (_builtTabs.containsKey(index)) {
      return _builtTabs[index]!;
    }

    late final Widget tab;
    switch (index) {
      case 0:
        tab = const LocationsList();
        break;
      case 1:
        tab = const LocationsMap();
        break;
      default:
        tab = const SizedBox();
    }

    _builtTabs[index] = tab;
    return tab;
  }

  @override
  void initState() {
    super.initState();
    bloc = context.read<LocationsBloc>();
    bloc.add(GeoStatusChecked());
    _tabController = TabController(
      initialIndex: initialIndex ?? 0,
      length: tabCount,
      vsync: this,
    );
    _currentIndex = _tabController.index;
    _tabController.addListener(() {
      if (_tabController.index != _currentIndex) {
        _currentIndex = _tabController.index;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<LocationsBloc, LocationsState>(
      listenWhen: (prev, curr) =>
          prev.showGeoModal != curr.showGeoModal && curr.showGeoModal,
      listener: (context, state) async {
        final result = await AppDialog.show(
          context,
          title: 'locationsScreen.modalTitle'.tr(),
          text: 'locationsScreen.modalText'.tr(),
          cancelText: 'productsScreen.cancelText'.tr(),
          okText: 'productsScreen.okText'.tr(),
        );
        if (result) {
          await Geolocator.openAppSettings();
        }
        bloc.add(GeoStatusModalDisabled());
      },
      builder: (context, state) {
        return Column(
          children: [
            Builder(
              key: ValueKey(context.locale),
              builder: (context) {
                return CustomTabBar(
                  tabs: [
                    'locationsScreen.list'.tr(),
                    'locationsScreen.map'.tr(),
                  ],
                  selectedIndex: _tabController.index,
                  useDifferentBorderForOuter: true,
                  onTap: (i) => _tabController.animateTo(i),
                  barDecoration: BoxDecoration(color: Colors.transparent),
                  barPadding: EdgeInsets.symmetric(vertical: 8.0),
                  buttonBorderRadius: 12.0,
                  buttonColor: theme.unselectedWidgetColor,
                  labelColor: theme.disabledColor,
                  selectedButtonColor: theme.colorScheme.primary,
                  selectedLabelColor: Colors.white,
                  separator: const SizedBox(),
                );
              },
            ),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : IndexedStack(
                      index: _tabController.index,
                      children: List.generate(tabCount, (i) => _buildTab(i)),
                    ),
            ),
          ],
        );
      },
    );
  }
}
