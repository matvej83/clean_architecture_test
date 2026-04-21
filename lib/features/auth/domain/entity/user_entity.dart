import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.avatar,
  });

  final String id;
  final String email;
  final String name;
  final String role;
  final String avatar;

  @override
  List<Object?> get props => [id, email, name, role, avatar];
}
