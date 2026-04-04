import 'dart:io';

import 'package:flutter/material.dart';

class ImagesList extends StatelessWidget {
  const ImagesList({
    super.key,
    required this.images,
    required this.onTap,
    this.maxLength = 3,
    required this.onRemove,
  });

  final List<File> images;
  final VoidCallback onTap;
  final Function(File) onRemove;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    final widgets = images.map(
      (e) => ListItem(key: ValueKey(e.path), image: e, onRemove: onRemove),
    );
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8.0,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...widgets,
          if (images.length < maxLength) AddImageItem(onTap: onTap),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.image, required this.onRemove});

  final File image;
  final Function(File) onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          width: 120.0,
          height: 120.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              image,
              errorBuilder: (context, o, s) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: theme.unselectedWidgetColor,
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            onRemove(image);
          },
          style: IconButton.styleFrom(
            backgroundColor: theme.primaryColor.withValues(alpha: 0.5),
          ),
          icon: Icon(Icons.delete, size: 24.0, color: Colors.white),
        ),
      ],
    );
  }
}

class AddImageItem extends StatelessWidget {
  const AddImageItem({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: theme.unselectedWidgetColor,
        ),
        width: 120.0,
        height: 120.0,
        child: Center(
          child: Icon(Icons.photo_library, size: 32.0, color: Colors.white),
        ),
      ),
    );
  }
}
