import 'dart:async';

import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_event.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../domain/usecases/fetch_user_usecase.dart';
import '../../domain/usecases/fetch_users_usecase.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final FetchUsersUseCase fetchUsersUseCase;
  final FetchUserUseCase fetchUserUseCase;

  UsersBloc({required this.fetchUsersUseCase, required this.fetchUserUseCase})
    : super(const UsersState()) {
    on<UsersFetched>(_onUsersFetched);
    on<UserFetched>(_onUserFetched);
  }

  FutureOr<void> _onUsersFetched(
    UsersFetched event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await fetchUsersUseCase(NoParams());

    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        }
        emit(state.copyWith(error: message, isLoading: false));
      },
      (r) {
        emit(state.copyWith(users: r, isLoading: false));
      },
    );
  }

  FutureOr<void> _onUserFetched(
    UserFetched event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(isUserLoading: true));

    final result = await fetchUserUseCase(FetchUserParams(id: event.id));

    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        }
        emit(state.copyWith(error: message, isUserLoading: false));
      },
      (r) {
        emit(state.copyWith(user: r, isUserLoading: false));
      },
    );
  }
}
