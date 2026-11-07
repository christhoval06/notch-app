import 'package:flutter/material.dart';

class PathProgressPainter extends CustomPainter {
  PathProgressPainter({
    required this.progress,
    required this.backgroundColor,
    required this.gradientTop,
    required this.gradientBottom,
  });

  final double progress;
  final Color backgroundColor;
  final Color gradientTop;
  final Color gradientBottom;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final foregroundPaint = Paint()
      ..shader = LinearGradient(
        colors: [gradientTop, gradientBottom],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, 0, size.height))
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width / 2, size.height);
    canvas.drawPath(path, backgroundPaint);

    final progressPath = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(size.width / 2, size.height * (1 - progress));
    canvas.drawPath(progressPath, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant PathProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
