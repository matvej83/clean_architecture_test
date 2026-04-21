import 'package:clean_architecture_test/core/constants/app_strings.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

import 'tile_cache_service.dart';

class TileCacheServiceImpl implements TileCacheService {
  TileProvider? _provider;

  @override
  Future<void> init() async {
    await FMTCObjectBoxBackend().initialise();

    const storeName = AppStrings.mapStoreName;

    final store = const FMTCStore(storeName);
    await store.manage.create();

    _provider = FMTCTileProvider(
      stores: const {storeName: BrowseStoreStrategy.readUpdateCreate},
      loadingStrategy: BrowseLoadingStrategy.cacheFirst,
    );
  }

  @override
  TileProvider? getTileProvider() => _provider;
}
