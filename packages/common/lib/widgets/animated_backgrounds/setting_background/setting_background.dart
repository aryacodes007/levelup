import 'dart:math';
import 'package:flutter/material.dart';
import 'package:common/common.dart';

part '_floating_shape.dart';
part '_floating_shape_painter.dart';

/// [SettingsBackground]
///
/// A background widget for the Settings screen with floating animated shapes.
///
/// Features:
/// - Animates multiple shapes ([_FloatingShape]) across the screen.
/// - Shapes can be circles, rounded rectangles, triangles, or diamonds ([type]).
/// - Each shape has random [x], [y] position, [size], [color], [rotation], and movement factors ([dxFactor], [dyFactor]).
/// - Shapes slowly drift and bounce off edges for a dynamic background.
/// - Uses an [AnimationController] to drive continuous animation.
///
/// State Management:
/// - Shapes are stored in the private [_shapes] list.
/// - Animation is controlled by [_controller].
///
/// UI Components:
/// - Uses [CustomPaint] and [_FloatingShapePainter] to render shapes.
class SettingsBackground extends StatefulWidget {
  final List<Color> colorPalette;

  const SettingsBackground({
    super.key,
    required this.colorPalette,
  });

  @override
  State<SettingsBackground> createState() => _SettingsBackgroundState();
}

class _SettingsBackgroundState extends State<SettingsBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_FloatingShape> _shapes = [];
  final int shapeCount = 45; // number of shapes
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();

    final shapeTypes = [
      AppConst.circle,
      AppConst.rrect,
      AppConst.triangle,
      AppConst.diamond,
    ];

    for (int i = 0; i < shapeCount; i++) {
      final size = _random.nextDouble() * 32 + 15;
      _shapes.add(
        _FloatingShape(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          size: size,
          color: widget
              .colorPalette[_random.nextInt(widget.colorPalette.length)]
              .withOpacity(0.3 + _random.nextDouble() * 0.2),
          rotation: _random.nextDouble() * 2 * pi,
          type: shapeTypes[_random.nextInt(shapeTypes.length)],
          dxFactor: (_random.nextDouble() * 2 - 1) * 0.5, // -0.5 to 0.5
          dyFactor: (_random.nextDouble() * 2 - 1) * 0.5,
          scalePhase: _random.nextDouble() * 2 * pi,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        for (var s in _shapes) {
          // Move
          s.x += s.dxFactor * 0.002;
          s.y += s.dyFactor * 0.002;

          // Bounce off edges
          if (s.x < 0 || s.x > 1) s.dxFactor *= -1;
          if (s.y < 0 || s.y > 1) s.dyFactor *= -1;
        }

        return CustomPaint(
          size: Size.infinite,
          painter: _FloatingShapePainter(_shapes, _controller.value),
        );
      },
    );
  }
}