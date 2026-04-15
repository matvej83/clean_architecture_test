import 'package:clean_architecture_test/features/auth/domain/entity/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_state.freezed.dart';

@freezed
abstract class UsersState with _$UsersState {
  const factory UsersState({
    @Default(false) bool isLoading,
    @Default(false) bool isUserLoading,
    String? error,
    @Default([]) List<UserEntity> users,
    UserEntity? user,
  }) = _UsersState;
}
