import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entity/location_entity.dart';

abstract class LocationsRepository {
  Future<Either<Failure, List<LocationEntity>>> fetchLocations({
    List<double>? origin,
    int? radius,
  });
}
