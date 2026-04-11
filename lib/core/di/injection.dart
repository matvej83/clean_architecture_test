import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../services/tile_cache/tile_cache_registration.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();

  await registerTileCache(getIt);
}
