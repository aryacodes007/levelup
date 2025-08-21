part of 'setting_background.dart';

/// [_FloatingShape]
///
/// Represents a floating shape for animated backgrounds or effects.
///
/// Each shape has:
/// - `x` and `y`: normalized position coordinates (0.0 - 1.0).
/// - `size`: the base size of the shape.
/// - `color`: the color of the shape.
/// - `rotation`: current rotation angle in radians.
/// - `type`: the type of shape (e.g., 'circle', 'square').
/// - `dxFactor` and `dyFactor`: directional movement multipliers.
/// - `scalePhase`: phase used for scaling/pulsing animations.

class _FloatingShape {
  double x;
  double y;
  double size;
  Color color;
  double rotation;
  String type;
  double dxFactor;
  double dyFactor;
  double scalePhase;

  _FloatingShape({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.rotation,
    required this.type,
    required this.dxFactor,
    required this.dyFactor,
    required this.scalePhase,
  });
}