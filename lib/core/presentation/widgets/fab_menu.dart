import 'dart:math' as math;
import 'package:flutter/material.dart';

class FabMenu extends StatefulWidget {
  const FabMenu({
    super.key,
    required this.onAddProductTap,
    required this.onAddCategoryTap,
  });

  final VoidCallback onAddProductTap;
  final VoidCallback onAddCategoryTap;

  @override
  State<FabMenu> createState() => _FabMenuState();
}

class _FabMenuState extends State<FabMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _open = false;

  final double radius = 100;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  void toggle() {
    setState(() => _open = !_open);
    _open ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          _buildOption(
            angle: 70,
            icon: Icons.add_shopping_cart,
            label: 'product',
            onTap: widget.onAddProductTap,
          ),
          _buildOption(
            angle: 20,
            icon: Icons.create_new_folder,
            label: 'category',
            onTap: widget.onAddCategoryTap,
          ),

          FloatingActionButton(
            onPressed: toggle,
            child: AnimatedRotation(
              turns: _open ? 0.125 : 0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required double angle,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final rad = angle * math.pi / 180;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final offset = Offset(
          math.cos(rad) * radius * _controller.value,
          math.sin(rad) * radius * _controller.value,
        );

        return Positioned(
          right: 0 + offset.dx,
          bottom: 0 + offset.dy,
          child: Transform.scale(
            scale: _controller.value,
            child: Opacity(
              opacity: _controller.value,
              child: FloatingActionButton.small(
                heroTag: label,
                onPressed: () {
                  toggle();
                  Future.delayed(const Duration(milliseconds: 200), () {
                    onTap.call();
                  });
                },
                child: Icon(icon, size: 20.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
