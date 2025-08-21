part of 'level_up_background.dart';

/// [_PulsingArrowPainter]
///
/// Custom painter that renders a list of pulsing arrows with upward animation.
///
/// Features:
/// - Continuous upward movement based on each arrow's [speed].
/// - Pulsing glow effect using sine-based opacity animation.
/// - Arrows are drawn using a rotated text character (`➤`) for simplicity.
/// - Positions are normalized (0.0–1.0) and scaled to the given canvas [size].
class _PulsingArrowPainter extends CustomPainter {
  final List<_Arrow> arrows;
  final double progress;
  final Size size;

  _PulsingArrowPainter(
      this.arrows,
      this.progress,
      this.size,
      );

  @override
  void paint(Canvas canvas, Size size) {
    for (var a in arrows) {
      // Continuous upward movement
      final dy = ((a.y - progress * a.speed) % 1.0) * size.height;

      // Keep arrows within full width
      final dx = a.x * size.width;

      // Pulsing glow
      final glowOpacity =
          0.3 + 0.7 * (0.5 + 0.5 * sin(1600 * pi * progress + a.phase));

      final textPainter = TextPainter(
        text: TextSpan(
          text: '➤',
          style: TextStyle(
            fontSize: a.size,
            color: Colors.orangeAccent.withOpacity(glowOpacity),
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(-pi / 2); // point upward
      textPainter.paint(canvas, Offset(-a.size / 2, -a.size / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}