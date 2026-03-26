import 'package:flutter/material.dart';

class CarouselSliderItem extends StatelessWidget {
  const CarouselSliderItem({super.key, this.image, this.current, this.total});

  final String? image;
  final int? current;
  final int? total;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return image != null
        ? Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.network(
                  image!,
                  errorBuilder: (context, o, s) => const SizedBox(),
                ),
              ),
              if (current != null && total != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${current! + 1} / $total',
                    style: textTheme.bodyMedium?.copyWith(color: Colors.black),
                  ),
                ),
            ],
          )
        : const SizedBox();
  }
}
