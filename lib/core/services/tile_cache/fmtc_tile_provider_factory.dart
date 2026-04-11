import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

import '../../constants/app_strings.dart';

class FmtcTileProviderFactory {
  static Future<FMTCTileProvider> create() async {
    await FMTCObjectBoxBackend().initialise();

    const storeName = AppStrings.mapStoreName;

    final store = FMTCStore(storeName);
    await store.manage.create();

    return FMTCTileProvider(
      stores: const {storeName: BrowseStoreStrategy.readUpdateCreate},
      loadingStrategy: BrowseLoadingStrategy.cacheFirst,
    );
  }
}
