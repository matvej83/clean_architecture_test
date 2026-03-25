// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean_architecture_test/core/di/module.dart' as _i1033;
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
import 'package:clean_architecture_test/features/auth/domain/usecases/login_usecase.dart'
    as _i778;
import 'package:clean_architecture_test/features/auth/domain/usecases/logout_usecase.dart'
    as _i211;
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_bloc.dart'
    as _i738;
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
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i306.AuthRemoteDataSource>(
      () => _i306.AuthRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i905.AuthLocalDataSource>(
      () => _i905.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
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
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i1033.RegisterModule {}
