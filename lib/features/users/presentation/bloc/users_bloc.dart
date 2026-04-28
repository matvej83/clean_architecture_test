import 'dart:async';

import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/auth/domain/entity/user_entity.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_event.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/usecases/fetch_user_usecase.dart';
import '../../domain/usecases/fetch_users_usecase.dart';

@lazySingleton
class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({required this.fetchUsersUseCase, required this.fetchUserUseCase})
    : super(const UsersState()) {
    on<UsersEvent>((event, emit) async {
      await event.map(
        usersFetched: (e) => _onUsersFetched(e, emit),
        userFetched: (e) => _onUserFetched(e, emit),
        moreUsersLoaded: (e) => _onLoadMoreUsers(e, emit),
      );
    });
  }

  final FetchUsersUseCase fetchUsersUseCase;
  final FetchUserUseCase fetchUserUseCase;

  final List<UserEntity> _allUsers = [];
  static const _pageSize = 20;

  Future<void> _onUsersFetched(
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
        _allUsers
          ..clear()
          ..addAll(r);

        final initialUsers = _allUsers.take(_pageSize).toList();
        emit(state.copyWith(users: initialUsers, isLoading: false));
      },
    );
  }

  Future<void> _onLoadMoreUsers(
    MoreUsersLoaded event,
    Emitter<UsersState> emit,
  ) async {
    if (state.hasReachedMaxUsers) return;

    final currentLength = state.users.length;

    final nextUsers = _allUsers.skip(currentLength).take(_pageSize).toList();

    final updatedList = List<UserEntity>.from(state.users)..addAll(nextUsers);

    emit(
      state.copyWith(
        users: updatedList,
        hasReachedMaxUsers: updatedList.length >= _allUsers.length,
      ),
    );
  }

  Future<void> _onUserFetched(
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
