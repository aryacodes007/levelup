import 'dart:math';
import 'package:flutter/material.dart';

part '_particle_painter.dart';
part '_particle.dart';

/// [HabitsBackground]
///
/// A widget that renders an animated water-like background with floating particles.
///
/// Features:
/// - Uses a list of [_Particle] objects to simulate small floating bubbles.
/// - Animates particles continuously using an [AnimationController].
/// - Particles move slowly and bounce when hitting the edges.
/// - Colors are chosen from a predefined water color palette.
///
/// Usage:
/// Place this widget behind other UI elements (e.g., in a Stack) to provide a dynamic,
/// water-inspired background effect for the habits screen.
class HabitsBackground extends StatefulWidget {
  const HabitsBackground({super.key});

  @override
  State<HabitsBackground> createState() => _HabitsBackgroundState();
}

class _HabitsBackgroundState extends State<HabitsBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final List<_Particle> _particles = [];

  // Water color palette
  final List<Color> waterColors = [
    const Color(0xFFB2EBF2), // light aqua
    const Color(0xFF80DEEA), // medium aqua
    const Color(0xFF4DD0E1), // deep aqua
    const Color(0xFF26C6DA), // bright water blue
    const Color(0xFF00BCD4), // cyan
    const Color(0xFF00ACC1), // darker cyan
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Create 40 floating particles
    for (int i = 0; i < 40; i++) {
      _particles.add(
        _Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          radius: _random.nextDouble() * 10 + 5,
          dx: (_random.nextDouble() - 0.5) * 0.002,
          dy: (_random.nextDouble() - 0.5) * 0.002,
          color: waterColors[_random.nextInt(waterColors.length)],
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
      builder: (context, _) {
        // Update particle positions
        for (var p in _particles) {
          p.x += p.dx;
          p.y += p.dy;
          if (p.x < 0 || p.x > 1) p.dx *= -1;
          if (p.y < 0 || p.y > 1) p.dy *= -1;
        }

        return CustomPaint(
          painter: _ParticlePainter(_particles),
          size: Size.infinite,
        );
      },
    );
  }
}
