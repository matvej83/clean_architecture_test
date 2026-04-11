import 'package:clean_architecture_test/core/services/tile_cache/tile_cache_service.dart';

import 'tile_cache_web.dart' if (dart.library.io) 'tile_cache_mobile.dart';

TileCacheService createTileCacheService() {
  return TileCacheServiceImpl();
}
