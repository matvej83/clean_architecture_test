import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/user_entity.dart';

part 'auth_state.freezed.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.unknown) AuthStatus status,
    UserEntity? user,
    @Default(false) bool isLoading,
    String? error,
  }) = _AuthState;
}
