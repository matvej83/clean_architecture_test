import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_test/core/presentation/widgets/image_loader.dart';
import 'package:flutter/material.dart';

import 'image_placeholder.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({super.key, required this.imageUrl, this.fit});

  final String imageUrl;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return const ImagePlaceholder();
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      placeholder: (_, s) => const ImageLoader(),
      errorWidget: (_, s, o) => const ImagePlaceholder(),
    );
  }
}
