import 'dart:async';

import 'package:clean_architecture_test/core/error/failure.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:clean_architecture_test/features/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:clean_architecture_test/features/auth/domain/usecases/login_usecase.dart';
import 'package:clean_architecture_test/features/auth/domain/usecases/logout_usecase.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_event.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthUseCase checkAuthUseCase;
  final GetUserProfileUseCase getUserProfileUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.checkAuthUseCase,
    required this.getUserProfileUseCase,
  }) : super(AuthState.initial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthUserProfileRequested>(_onAuthUserProfileRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  FutureOr<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await checkAuthUseCase(NoParams());

    final isAuth = result.getOrElse(() => false);

    if (!isAuth) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
      return;
    }

    final userResult = await getUserProfileUseCase(NoParams());

    userResult.fold(
      (l) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      },
      (r) {
        emit(state.copyWith(status: AuthStatus.authenticated, user: r));
      },
    );
  }

  FutureOr<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (l) {
        String message = 'errors.authError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        } else if (l is ServerFailure) {
          message = 'errors.serverError'.tr();
        }
        emit(state.copyWith(error: message, isLoading: false));
      },
      (r) {
        add(AuthUserProfileRequested());
        emit(
          state.copyWith(status: AuthStatus.authenticated, isLoading: false),
        );
      },
    );
  }

  FutureOr<void> _onAuthUserProfileRequested(
    AuthUserProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getUserProfileUseCase(NoParams());
    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.accessTokenInvalid'.tr();
        }
        emit(state.copyWith(error: message, isLoading: false));
      },
      (r) {
        emit(state.copyWith(user: r, isLoading: false));
      },
    );
  }

  FutureOr<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await logoutUseCase(NoParams());
    result.fold(
      (l) {
        String message = 'errors.logoutError'.tr();
        emit(state.copyWith(error: message, isLoading: false));
      },
      (r) {
        emit(
          state.copyWith(status: AuthStatus.unauthenticated, isLoading: false),
        );
      },
    );
  }
}
