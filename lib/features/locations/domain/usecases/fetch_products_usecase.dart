import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entity/location_entity.dart';
import '../repository/locations_repository.dart';

@lazySingleton
class FetchLocationsUseCase
    implements UseCase<List<LocationEntity>, FetchLocationsParams> {
  final LocationsRepository repository;

  FetchLocationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<LocationEntity>>> call(
    FetchLocationsParams params,
  ) async {
    return await repository.fetchLocations(
      origin: params.origin,
      radius: params.radius,
    );
  }
}

class FetchLocationsParams {
  final List<double>? origin;
  final int? radius;

  FetchLocationsParams({this.origin, this.radius});
}
