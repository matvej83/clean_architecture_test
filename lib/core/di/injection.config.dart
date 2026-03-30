// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean_architecture_test/core/di/modules/network_module.dart'
    as _i10;
import 'package:clean_architecture_test/core/di/modules/shared_pref_module.dart'
    as _i109;
import 'package:clean_architecture_test/core/network/http_interceptors.dart'
    as _i863;
import 'package:clean_architecture_test/core/services/auth_session_manager.dart'
    as _i649;
import 'package:clean_architecture_test/core/services/geolocation_service.dart'
    as _i139;
import 'package:clean_architecture_test/features/auth/data/data_sources/auth_local_data_source.dart'
    as _i905;
import 'package:clean_architecture_test/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i306;
import 'package:clean_architecture_test/features/auth/data/repository/auth_repository_impl.dart'
    as _i111;
import 'package:clean_architecture_test/features/auth/domain/repository/auth_repository.dart'
    as _i563;
import 'package:clean_architecture_test/features/auth/domain/usecases/check_auth_usecase.dart'
    as _i1053;
import 'package:clean_architecture_test/features/auth/domain/usecases/get_user_profile_usecase.dart'
    as _i982;
import 'package:clean_architecture_test/features/auth/domain/usecases/login_usecase.dart'
    as _i778;
import 'package:clean_architecture_test/features/auth/domain/usecases/logout_usecase.dart'
    as _i211;
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_bloc.dart'
    as _i738;
import 'package:clean_architecture_test/features/locations/data/data_sources/locations_remote_data_source.dart'
    as _i198;
import 'package:clean_architecture_test/features/locations/data/repository/products_repository_impl.dart'
    as _i332;
import 'package:clean_architecture_test/features/locations/domain/repository/locations_repository.dart'
    as _i1056;
import 'package:clean_architecture_test/features/locations/domain/usecases/fetch_products_usecase.dart'
    as _i548;
import 'package:clean_architecture_test/features/products/data/data_sources/products_remote_data_source.dart'
    as _i223;
import 'package:clean_architecture_test/features/products/data/repository/products_repository_impl.dart'
    as _i4;
import 'package:clean_architecture_test/features/products/domain/repository/products_repository.dart'
    as _i557;
import 'package:clean_architecture_test/features/products/domain/usecases/fetch_categories_usecase.dart'
    as _i1043;
import 'package:clean_architecture_test/features/products/domain/usecases/fetch_product_usecase.dart'
    as _i994;
import 'package:clean_architecture_test/features/products/domain/usecases/fetch_products_usecase.dart'
    as _i542;
import 'package:clean_architecture_test/features/products/domain/usecases/fetch_related_by_id_usecase.dart'
    as _i460;
import 'package:clean_architecture_test/features/users/data/data_sources/users_remote_data_source.dart'
    as _i638;
import 'package:clean_architecture_test/features/users/data/repository/users_repository_impl.dart'
    as _i868;
import 'package:clean_architecture_test/features/users/domain/repository/users_repository.dart'
    as _i1001;
import 'package:clean_architecture_test/features/users/domain/usecases/fetch_user_usecase.dart'
    as _i487;
import 'package:clean_architecture_test/features/users/domain/usecases/fetch_users_usecase.dart'
    as _i788;
import 'package:clean_architecture_test/navigation/router.dart' as _i657;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPrefModule = _$SharedPrefModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i863.ErrorInterceptor>(() => _i863.ErrorInterceptor());
    gh.lazySingleton<_i649.AuthSessionManager>(
      () => _i649.AuthSessionManager(),
    );
    gh.lazySingleton<_i139.GeolocationService>(
      () => _i139.GeolocationService(),
    );
    gh.lazySingleton<_i905.AuthLocalDataSource>(
      () => _i905.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.refreshDio(),
      instanceName: 'refresh_dio',
    );
    gh.lazySingleton<_i863.AuthInterceptor>(
      () => _i863.AuthInterceptor(
        gh<_i905.AuthLocalDataSource>(),
        gh<_i649.AuthSessionManager>(),
        gh<_i361.Dio>(instanceName: 'refresh_dio'),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(
        gh<_i863.AuthInterceptor>(),
        gh<_i863.ErrorInterceptor>(),
      ),
    );
    gh.lazySingleton<_i306.AuthRemoteDataSource>(
      () => _i306.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i638.UsersRemoteDataSource>(
      () => _i638.UsersRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i223.ProductsRemoteDataSource>(
      () => _i223.ProductsRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i563.AuthRepository>(
      () => _i111.AuthRepositoryImpl(
        authLocalDataSource: gh<_i905.AuthLocalDataSource>(),
        authRemoteDataSource: gh<_i306.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1053.CheckAuthUseCase>(
      () => _i1053.CheckAuthUseCase(gh<_i563.AuthRepository>()),
    );
    gh.lazySingleton<_i982.GetUserProfileUseCase>(
      () => _i982.GetUserProfileUseCase(gh<_i563.AuthRepository>()),
    );
    gh.lazySingleton<_i778.LoginUseCase>(
      () => _i778.LoginUseCase(gh<_i563.AuthRepository>()),
    );
    gh.lazySingleton<_i211.LogoutUseCase>(
      () => _i211.LogoutUseCase(gh<_i563.AuthRepository>()),
    );
    gh.lazySingleton<_i198.LocationsRemoteDataSource>(
      () => _i198.LocationsRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i557.ProductsRepository>(
      () => _i4.ProductsRepositoryImpl(
        productsRemoteDataSource: gh<_i223.ProductsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1056.LocationsRepository>(
      () => _i332.LocationsRepositoryImpl(
        locationsRemoteDataSource: gh<_i198.LocationsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i738.AuthBloc>(
      () => _i738.AuthBloc(
        loginUseCase: gh<_i778.LoginUseCase>(),
        logoutUseCase: gh<_i211.LogoutUseCase>(),
        checkAuthUseCase: gh<_i1053.CheckAuthUseCase>(),
        getUserProfileUseCase: gh<_i982.GetUserProfileUseCase>(),
      ),
    );
    gh.lazySingleton<_i657.AppRouter>(
      () => _i657.AppRouter(gh<_i738.AuthBloc>()),
    );
    gh.lazySingleton<_i1001.UsersRepository>(
      () => _i868.UsersRepositoryImpl(
        productsRemoteDataSource: gh<_i638.UsersRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i487.FetchUserUseCase>(
      () => _i487.FetchUserUseCase(gh<_i1001.UsersRepository>()),
    );
    gh.lazySingleton<_i788.FetchUsersUseCase>(
      () => _i788.FetchUsersUseCase(gh<_i1001.UsersRepository>()),
    );
    gh.lazySingleton<_i1043.FetchCategoriesUseCase>(
      () => _i1043.FetchCategoriesUseCase(gh<_i557.ProductsRepository>()),
    );
    gh.lazySingleton<_i994.FetchProductUseCase>(
      () => _i994.FetchProductUseCase(gh<_i557.ProductsRepository>()),
    );
    gh.lazySingleton<_i542.FetchProductsUseCase>(
      () => _i542.FetchProductsUseCase(gh<_i557.ProductsRepository>()),
    );
    gh.lazySingleton<_i460.FetchRelatedByIdUseCase>(
      () => _i460.FetchRelatedByIdUseCase(gh<_i557.ProductsRepository>()),
    );
    gh.lazySingleton<_i548.FetchLocationsUseCase>(
      () => _i548.FetchLocationsUseCase(gh<_i1056.LocationsRepository>()),
    );
    return this;
  }
}

class _$SharedPrefModule extends _i109.SharedPrefModule {}

class _$NetworkModule extends _i10.NetworkModule {}
