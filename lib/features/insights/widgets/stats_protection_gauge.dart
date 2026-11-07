import 'package:flutter/material.dart';

class StatsProtectionGauge extends StatelessWidget {
  const StatsProtectionGauge({
    super.key,
    required this.value,
    required this.label,
  });

  final double value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 136,
          height: 136,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: 12,
            backgroundColor: scheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(scheme.tertiary),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${(value * 100).round()}%',
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      ],
    );
  }
}
