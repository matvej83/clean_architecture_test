import 'package:get_it/get_it.dart';

import 'tile_cache_impl.dart';
import 'tile_cache_service.dart';

Future<void> registerTileCache(GetIt getIt) async {
  final service = createTileCacheService();

  await service.init();

  getIt.registerSingleton<TileCacheService>(service);
}
