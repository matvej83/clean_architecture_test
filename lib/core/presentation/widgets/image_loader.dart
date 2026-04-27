import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'image_placeholder.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: Colors.transparent,
      highlightColor: theme.onPrimary,
      child: const ImagePlaceholder(),
    );
  }
}
