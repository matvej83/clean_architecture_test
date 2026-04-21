import 'package:clean_architecture_test/core/error/exception.dart';
import 'package:clean_architecture_test/features/locations/data/models/location_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class LocationsRemoteDataSource {
  Future<List<LocationModel>?> fetchLocations({
    List<double>? origin,
    int? radius,
  });
}

@LazySingleton(as: LocationsRemoteDataSource)
class LocationsRemoteDataSourceImpl implements LocationsRemoteDataSource {
  LocationsRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<LocationModel>?> fetchLocations({
    List<double>? origin,
    int? radius,
  }) async {
    try {
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
    } on Exception catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        throw InvalidCredentialsException();
      } else {
        throw ServerException();
      }
    }
    return null;
  }
}
