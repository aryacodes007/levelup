part of 'bubble_background.dart';

/// [_Bubble]
///
/// A model class representing a single bubble in the animated background.
///
/// Properties:
/// - [x], [y] → Position of the bubble.
/// - [radius] → Radius (size) of the bubble.
/// - [speed] → Vertical movement speed of the bubble.
/// - [color] → Bubble color.
class _Bubble {
  double x;
  double y;
  double radius;
  double speed;
  Color color;

  _Bubble({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.color,
  });
}
