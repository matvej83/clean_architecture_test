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
import 'package:clean_architecture_test/features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i643;
import 'package:clean_architecture_test/features/auth/domain/usecases/get_user_profile_usecase.dart'
    as _i982;
import 'package:clean_architecture_test/features/auth/domain/usecases/login_usecase.dart'
    as _i778;
import 'package:clean_architecture_test/features/auth/domain/usecases/logout_usecase.dart'
    as _i211;
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_bloc.dart'
    as _i738;
import 'package:clean_architecture_test/features/products/data/data_sources/products_remote_data_source.dart'
    as _i223;
import 'package:clean_architecture_test/features/products/data/repository/products_repository_impl.dart'
    as _i4;
import 'package:clean_architecture_test/features/products/domain/repository/products_repository.dart'
    as _i557;
import 'package:clean_architecture_test/features/products/domain/usecases/fetch_products_usecase.dart'
    as _i542;
import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart'
    as _i1063;
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
    gh.lazySingleton<_i905.AuthLocalDataSource>(
      () => _i905.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.refreshDio(),
      instanceName: 'refresh_dio',
    );
    gh.lazySingleton<_i649.AuthSessionManager>(
      () => _i649.AuthSessionManager(gh<_i905.AuthLocalDataSource>()),
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
    gh.lazySingleton<_i643.GetCurrentUserUseCase>(
      () => _i643.GetCurrentUserUseCase(gh<_i563.AuthRepository>()),
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
    gh.lazySingleton<_i738.AuthBloc>(
      () => _i738.AuthBloc(
        loginUseCase: gh<_i778.LoginUseCase>(),
        logoutUseCase: gh<_i211.LogoutUseCase>(),
        getCurrentUserUseCase: gh<_i643.GetCurrentUserUseCase>(),
        checkAuthUseCase: gh<_i1053.CheckAuthUseCase>(),
        getUserProfileUseCase: gh<_i982.GetUserProfileUseCase>(),
      ),
    );
    gh.lazySingleton<_i557.ProductsRepository>(
      () => _i4.ProductsRepositoryImpl(
        productsRemoteDataSource: gh<_i223.ProductsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i542.FetchProductsUseCase>(
      () => _i542.FetchProductsUseCase(gh<_i557.ProductsRepository>()),
    );
    gh.lazySingleton<_i1063.ProductsBloc>(
      () => _i1063.ProductsBloc(
        fetchProductsUseCase: gh<_i542.FetchProductsUseCase>(),
      ),
    );
    return this;
  }
}

class _$SharedPrefModule extends _i109.SharedPrefModule {}

class _$NetworkModule extends _i10.NetworkModule {}
