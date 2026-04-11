import 'package:flutter_map/flutter_map.dart';

abstract class TileCacheService {
  Future<void> init();

  TileProvider? getTileProvider();
}
