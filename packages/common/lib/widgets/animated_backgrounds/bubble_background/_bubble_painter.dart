part of 'bubble_background.dart';

/// [_BubblePainter]
///
/// A [CustomPainter] responsible for rendering animated bubbles.
///
/// - Uses a list of [_Bubble] objects to draw circles on the [Canvas].
/// - Bubble position is calculated using [progress] and each bubble’s [speed].
/// - Opacity adapts to [isDark] mode for better theme integration.
class _BubblePainter extends CustomPainter {
  final List<_Bubble> bubbles;
  final double progress;
  final bool isDark;

  _BubblePainter({
    required this.bubbles,
    required this.progress,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var bubble in bubbles) {
      final dx = bubble.x * size.width;
      final dy =
          (bubble.y * size.height - progress * bubble.speed * size.height) %
              size.height;

      final paint = Paint()
        ..color = bubble.color.withOpacity(isDark ? 0.6 : 0.4)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(dx, dy), bubble.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
