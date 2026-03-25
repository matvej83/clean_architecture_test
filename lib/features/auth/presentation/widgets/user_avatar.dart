import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.avatar});

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40.0,
      backgroundImage: NetworkImage(avatar),
      onBackgroundImageError: (o, s) => const SizedBox(),
    );
  }
}
