import 'package:clean_architecture_test/features/auth/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

class UsersState extends Equatable {
  final bool isLoading;
  final bool isUserLoading;
  final String? error;
  final List<UserEntity> users;
  final UserEntity? user;

  const UsersState({
    this.isLoading = false,
    this.isUserLoading = false,
    this.error,
    this.users = const [],
    this.user,
  });

  UsersState copyWith({
    bool? isLoading,
    bool? isUserLoading,
    String? error,
    List<UserEntity>? users,
    UserEntity? user,
  }) {
    return UsersState(
      isLoading: isLoading ?? this.isLoading,
      isUserLoading: isUserLoading ?? this.isUserLoading,
      error: error,
      users: users ?? this.users,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [isLoading, isUserLoading, error, users, user];
}
