// import 'package:flutter/foundation.dart';
// import 'package:injectable/injectable.dart';
//
// import '../../services/tile_cache/tile_cache_service.dart';
// import '../../services/tile_cache/tile_cache_service_mobile.dart';
// import '../../services/tile_cache/tile_cache_service_web.dart';
//
// @module
// abstract class TileCacheModule {
//   @preResolve
//   Future<TileCacheService> get tileCache async {
//     late final TileCacheService service;
//
//     if (kIsWeb) {
//       service = TileCacheServiceWeb();
//     } else {
//       service = TileCacheServiceMobile();
//     }
//
//     await service.init();
//
//     return service;
//   }
// }
