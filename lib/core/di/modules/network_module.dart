import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../app_env.dart';
import '../../network/http_interceptors.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor, ErrorInterceptor errorInterceptor) {
    final dio = Dio(_baseOptions);

    dio.interceptors.addAll([authInterceptor, errorInterceptor]);

    return dio;
  }

  @Named('refresh_dio')
  @lazySingleton
  Dio refreshDio() {
    return Dio(_baseOptions);
  }
}

final _baseOptions = BaseOptions(
  baseUrl: AppEnv.baseUrl,
  contentType: 'application/json',
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
);
