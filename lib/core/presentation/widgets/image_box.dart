import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'image_placeholder.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({super.key, required this.imageUrl, this.fit});

  final String imageUrl;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      errorWidget: (context, o, s) => const ImagePlaceholder(),
    );
  }
}
