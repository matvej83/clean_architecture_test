import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';

import 'tile_cache_service.dart';
import 'fmtc_tile_provider_factory.dart';

class TileCacheServiceImpl implements TileCacheService {
    TileProvider? _provider;

    @override
    Future<void> init() async {
        if (kIsWeb) {
            _provider = null;
            return;
        }

        _provider = await FmtcTileProviderFactory.create();
    }

    @override
    TileProvider? getTileProvider() => _provider;
}