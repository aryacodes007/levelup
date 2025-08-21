part of 'habits_background.dart';

/// [_ParticlePainter]
///
/// A custom painter that draws a list of [_Particle] objects on the canvas.
///
/// Each particle is drawn as a circle with a radial gradient.
/// - [particles]: The list of particles to render.
/// - [_random]: Internal random generator (unused in paint but available for extensions).
class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final Random _random = Random();

  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final dx = p.x * size.width;
      final dy = p.y * size.height;

      // Gradient for particle
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            p.color.withOpacity(0.7),
            p.color.withOpacity(0.3),
          ],
        ).createShader(Rect.fromCircle(center: Offset(dx, dy), radius: p.radius));

      canvas.drawCircle(Offset(dx, dy), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}