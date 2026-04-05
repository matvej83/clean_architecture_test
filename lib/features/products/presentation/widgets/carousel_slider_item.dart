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
                  errorBuilder: (context, o, s) =>
                      Container(color: Colors.white24),
                ),
              ),
              if (current != null && total != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 4.0),
                    padding: EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.cyan.withValues(alpha: 0.2),
                    ),
                    child: Text(
                      '${current! + 1} / $total',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ),
            ],
          )
        : const SizedBox();
  }
}
