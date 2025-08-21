part of 'setting_background.dart';

class _FloatingShapePainter extends CustomPainter {
  final List<_FloatingShape> shapes;
  final double progress;

  _FloatingShapePainter(this.shapes, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (var s in shapes) {
      final dx = s.x * size.width;
      final dy = s.y * size.height;

      // Pulsing glow
      final glow =
          0.2 + 0.6 * (0.5 + 0.5 * sin(10 * pi * progress + s.scalePhase));

      // Pulsing size
      final scale =
          0.9 + 0.2 * (0.5 + 0.5 * sin(8 * pi * progress + s.scalePhase));
      final scaledSize = s.size * scale;

      final paint = Paint()
        ..shader = RadialGradient(
          colors: [s.color.withOpacity(glow), s.color.withOpacity(glow * 0.3)],
        ).createShader(Rect.fromLTWH(0, 0, scaledSize, scaledSize));

      canvas.save();
      canvas.translate(dx + scaledSize / 2, dy + scaledSize / 2);
      canvas.rotate(s.rotation + progress * 2 * pi * 0.03);
      canvas.translate(-scaledSize / 2, -scaledSize / 2);

      switch (s.type) {
        case AppConst.circle:
          canvas.drawOval(Rect.fromLTWH(0, 0, scaledSize, scaledSize), paint);
          break;
        case AppConst.rrect:
          final rect = RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, scaledSize, scaledSize),
            Radius.circular(scaledSize * 0.2),
          );
          canvas.drawRRect(rect, paint);
          break;
        case AppConst.triangle:
          final path = Path()
            ..moveTo(scaledSize / 2, 0)
            ..lineTo(scaledSize, scaledSize)
            ..lineTo(0, scaledSize)
            ..close();
          canvas.drawPath(path, paint);
          break;
        case AppConst.diamond:
          final path = Path()
            ..moveTo(scaledSize / 2, 0)
            ..lineTo(scaledSize, scaledSize / 2)
            ..lineTo(scaledSize / 2, scaledSize)
            ..lineTo(0, scaledSize / 2)
            ..close();
          canvas.drawPath(path, paint);
          break;
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}