import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'image_box.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({super.key, required this.imageUrl});

  final String imageUrl;

  static void show(BuildContext context, {required String imageUrl}) {
    showDialog(
      context: context,
      fullscreenDialog: true,
      barrierColor: Colors.black,
      barrierDismissible: true,
      builder: (_) => FullScreenImage(imageUrl: imageUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        InteractiveViewer(
          minScale: 1,
          maxScale: 4,
          child: ImageBox(imageUrl: imageUrl),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.close, size: 32.0),
          ),
        ),
      ],
    );
  }
}
