import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/network/base_remote_data_source.dart';
import 'package:store_app/features/locations/data/models/location_model.dart';

abstract class LocationsRemoteDataSource {
  Future<List<LocationModel>?> fetchLocations({
    List<double>? origin,
    int? radius,
  });
}

@LazySingleton(as: LocationsRemoteDataSource)
class LocationsRemoteDataSourceImpl extends BaseRemoteDataSource
    implements LocationsRemoteDataSource {
  LocationsRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<LocationModel>?> fetchLocations({
    List<double>? origin,
    int? radius,
  }) async {
    return makeRequest<List<LocationModel>?>(() async {
      Map<String, dynamic> queryParameters = {};
      if (origin != null) {
        queryParameters.addAll({'origin': origin});
      }
      if (radius != null) {
        queryParameters.addAll({'radius': radius});
      }
      final response = await dio.get(
        'locations',
        queryParameters: queryParameters,
      );
      if (response.data != null) {
        return LocationModel.fromList(response.data);
      }
      return null;
    });
  }
}
