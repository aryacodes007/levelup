part of 'level_up_background.dart';

/// [_Arrow]
///
/// Represents a floating shape for animated backgrounds or effects.
///
/// Each shape has:
/// - [x] and [y]: normalized position coordinates (0.0 - 1.0).
/// - [size]: the base size of the shape.
/// - [color]: the color of the shape.
/// - [rotation]: current rotation angle in radians.
/// - [type]: the type of shape (e.g., 'circle', 'square').
/// - [dxFactor] and [dyFactor]: directional movement multipliers.
/// - [scalePhase]: phase used for scaling/pulsing animations.
class _Arrow {
  double x;
  double y;
  double size;
  double speed;
  double phase;
  Color color;

  _Arrow({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.phase,
    required this.color,
  });
}