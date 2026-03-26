import 'package:equatable/equatable.dart';

abstract class UsersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersFetched extends UsersEvent {}

class UserFetched extends UsersEvent {
  final String id;

  UserFetched(this.id);

  @override
  List<Object?> get props => [id];
}
