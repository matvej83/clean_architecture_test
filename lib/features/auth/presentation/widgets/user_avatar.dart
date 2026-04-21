import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_test/core/presentation/widgets/image_placeholder.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.avatar});

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40.0,
      backgroundImage: CachedNetworkImageProvider(avatar),
      onBackgroundImageError: (o, s) => const ImagePlaceholder(),
    );
  }
}
