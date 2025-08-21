part of 'habits_background.dart';

/// [_Particle]
///
/// Represents a single particle used in animations.
///
/// Each particle has:
/// - [x], [y]: Position coordinates.
/// - [radius]: Size of the particle.
/// - [dx], [dy]: Velocity along the x and y axes.
/// - [color]: Color of the particle.
class _Particle {
  double x, y, radius, dx, dy;
  Color color;
  _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.dx,
    required this.dy,
    required this.color,
  });
}