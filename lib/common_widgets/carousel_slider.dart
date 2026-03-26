import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({
    super.key,
    this.height,
    required this.itemCount,
    required this.initialPage,
    required this.itemBuilder,
    required this.controller,
    this.onPageChanged,
    this.enableInfiniteScroll = true,
  });

  final double? height;
  final int itemCount;
  final int initialPage;
  final Widget Function(BuildContext, int, int) itemBuilder;
  final CarouselSliderController controller;
  final Function(int)? onPageChanged;
  final bool enableInfiniteScroll;

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: widget.controller,
      itemCount: widget.itemCount,
      options: CarouselOptions(
        height: widget.height,
        initialPage: widget.initialPage,
        viewportFraction: 0.82,
        enlargeCenterPage: false,
        autoPlay: false,
        scrollDirection: Axis.horizontal,
        enableInfiniteScroll: widget.enableInfiniteScroll,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
          });
          if (widget.onPageChanged != null) {
            widget.onPageChanged!(index);
          }
        },
      ),
      itemBuilder: widget.itemBuilder,
    );
  }
}
