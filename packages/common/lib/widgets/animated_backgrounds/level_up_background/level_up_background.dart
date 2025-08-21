import 'dart:math';
import 'package:flutter/material.dart';

part '_arrow.dart';
part '_pulsing_arrow_painter.dart';

/// [LevelUpBackground]
///
/// A dynamic background widget for the LevelUp screen.
///
/// Features:
/// - Displays multiple upward-moving arrows (`_Arrow`) with randomized positions, sizes, speeds, and colors.
/// - Each arrow has a pulsing glow effect handled by [_PulsingArrowPainter].
/// - The animation runs continuously using an [AnimationController] with a long duration to create a subtle background motion.
/// - Fully fills available space using [CustomPaint].
class LevelUpBackground extends StatefulWidget {
  const LevelUpBackground({super.key});

  @override
  State<LevelUpBackground> createState() => _LevelUpBackgroundState();
}

class _LevelUpBackgroundState extends State<LevelUpBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_Arrow> _arrows = [];
  final int arrowCount = 60; // increase for more coverage
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(hours: 1),
    )..repeat();

    for (int i = 0; i < arrowCount; i++) {
      _arrows.add(
        _Arrow(
          x: _random.nextDouble(), // full width
          y: _random.nextDouble(), // full height
          size: _random.nextDouble() * 18 + 14,
          speed: _random.nextDouble() * 200 + 120,
          phase: _random.nextDouble() * 2 * pi,
          color: Colors.primaries[_random.nextInt(Colors.primaries.length)]
              .withOpacity(0.6),
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
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          size: Size.infinite,
          painter:
          _PulsingArrowPainter(_arrows, _controller.value, size),
        );
      },
    );
  }
}