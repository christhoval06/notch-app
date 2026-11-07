import 'package:flutter/material.dart';

class StatsHeatmapDayFactChip extends StatelessWidget {
  const StatsHeatmapDayFactChip({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class StatsHeatmapDayTagPill extends StatelessWidget {
  const StatsHeatmapDayTagPill({
    super.key,
    required this.label,
    required this.tone,
    required this.textColor,
  });

  final String label;
  final Color tone;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tone,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
    );
  }
}
