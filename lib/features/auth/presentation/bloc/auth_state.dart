import 'package:equatable/equatable.dart';

import '../../domain/entity/user_entity.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    required this.status,
    this.user,
    this.isLoading = false,
    this.error,
  });

  factory AuthState.initial() => const AuthState(status: AuthStatus.unknown);

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, user, isLoading, error];
}
