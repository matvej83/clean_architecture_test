import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/error/mapper.dart';
import 'package:clean_architecture_test/features/locations/domain/entity/location_entity.dart';
import 'package:clean_architecture_test/features/locations/domain/repository/locations_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/locations_remote_data_source.dart';
import '../models/location_model.dart';

@LazySingleton(as: LocationsRepository)
class LocationsRepositoryImpl implements LocationsRepository {
  final LocationsRemoteDataSource locationsRemoteDataSource;

  LocationsRepositoryImpl({required this.locationsRemoteDataSource});

  @override
  Future<Either<Failure, List<LocationEntity>>> fetchLocations({
    List<double>? origin,
    int? radius,
  }) async {
    try {
      final locations = await locationsRemoteDataSource.fetchLocations(
        origin: origin,
        radius: radius,
      );
      final list = locations?.map((e) => e.toEntity()).toList() ?? [];
      return Right(list);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
