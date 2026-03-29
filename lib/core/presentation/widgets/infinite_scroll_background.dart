import 'dart:math' as math;

import 'package:flutter/material.dart';

class InfiniteScrollingBackground extends StatefulWidget {
  final String backgroundImage;
  final String foregroundImage;
  final double animationHeight;
  final double foregroundImageSize;
  final Duration duration;
  final double? foregroundImageBottomPosition;

  const InfiniteScrollingBackground({
    super.key,
    required this.backgroundImage,
    required this.foregroundImage,
    this.animationHeight = 250.0,
    this.foregroundImageSize = 160.0,
    this.duration = const Duration(seconds: 10),
    this.foregroundImageBottomPosition,
  });

  @override
  State<InfiniteScrollingBackground> createState() =>
      _InfiniteScrollingBackgroundState();
}

class _InfiniteScrollingBackgroundState
    extends State<InfiniteScrollingBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage(widget.backgroundImage), context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.animationHeight,
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          // Moving background
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned.fill(
                child: Flow(
                  delegate: _InfiniteFlowDelegate(
                    translation: _controller.value,
                  ),
                  children: [
                    // Create 3 copies
                    _buildBackground(),
                    _buildBackground(),
                    _buildBackground(),
                  ],
                ),
              );
            },
          ),

          Positioned(
            bottom: widget.foregroundImageBottomPosition ?? 0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // Build Y offset cycle
                final double offsetY =
                    12 * math.sin(2 * math.pi * _controller.value);

                return Transform.translate(
                  offset: Offset(0, offsetY),
                  child: Image.asset(
                    widget.foregroundImage,
                    width: widget.foregroundImageSize,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Image.asset(
      widget.backgroundImage,
      fit: BoxFit.cover,
      repeat: ImageRepeat.repeatX,
    );
  }
}

class _InfiniteFlowDelegate extends FlowDelegate {
  final double translation;

  _InfiniteFlowDelegate({required this.translation});

  @override
  void paintChildren(FlowPaintingContext context) {
    final double width = context.size.width;
    double xOffset = -translation * width;
    for (int i = 0; i < context.childCount; i++) {
      context.paintChild(
        i,
        transform: Matrix4.translationValues(xOffset + (i * width), 0, 0),
      );
    }
  }

  @override
  bool shouldRepaint(_InfiniteFlowDelegate oldDelegate) =>
      oldDelegate.translation != translation;
}
