import 'dart:math';
import 'package:flutter/material.dart';
part '_bubble_painter.dart';
part '_bubble.dart';

/// A reusable animated bubble background widget.
/// Can be used in splash screens or gamified backgrounds.
class BubbleBackground extends StatefulWidget {
  final bool isDark;
  final List<Color> bubbleColors;
  final int bubbleCount;

  const BubbleBackground({
    super.key,
    required this.isDark,
    required this.bubbleColors,
    this.bubbleCount = 50,
  });

  @override
  State<BubbleBackground> createState() => _BubbleBackgroundState();
}

class _BubbleBackgroundState extends State<BubbleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Bubble> _bubbles;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _bubbles = _generateBubbles(widget.bubbleCount);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  List<_Bubble> _generateBubbles(int count) {
    return List.generate(count, (_) {
      return _Bubble(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        radius: _random.nextDouble() * 15 + 5,
        speed: _random.nextDouble() * 0.5 + 0.2,
        color: widget.bubbleColors[_random.nextInt(widget.bubbleColors.length)],
      );
    });
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
        return CustomPaint(
          size: Size.infinite,
          painter: _BubblePainter(
            bubbles: _bubbles,
            progress: _controller.value,
            isDark: widget.isDark,
          ),
        );
      },
    );
  }
}
