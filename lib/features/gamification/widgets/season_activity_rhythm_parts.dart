import 'dart:math' as math;

import 'package:flutter/material.dart';

class SeasonActivityGaugePainter extends CustomPainter {
  SeasonActivityGaugePainter({
    required this.dayShare,
    required this.nightShare,
    required this.dayColor,
    required this.nightColor,
  });

  final double dayShare;
  final double nightShare;
  final Color dayColor;
  final Color nightColor;

  @override
  void paint(Canvas canvas, Size size) {
    const start = math.pi;
    const sweep = math.pi;
    final rect = Rect.fromLTWH(6, 6, size.width - 12, (size.height * 2) - 12);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final daySweep = sweep * dayShare.clamp(0.0, 1.0);
    final nightSweep = sweep * nightShare.clamp(0.0, 1.0);

    canvas.drawArc(
      rect,
      start,
      daySweep,
      false,
      stroke..color = dayColor,
    );
    canvas.drawArc(
      rect,
      start + daySweep,
      nightSweep,
      false,
      stroke..color = nightColor,
    );
  }

  @override
  bool shouldRepaint(covariant SeasonActivityGaugePainter oldDelegate) {
    return oldDelegate.dayShare != dayShare ||
        oldDelegate.nightShare != nightShare ||
        oldDelegate.dayColor != dayColor ||
        oldDelegate.nightColor != nightColor;
  }
}

class SeasonActivityMetricBox extends StatelessWidget {
  const SeasonActivityMetricBox({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
