import 'package:flutter/material.dart';

class StatsRhythmBucketBar extends StatelessWidget {
  const StatsRhythmBucketBar({
    super.key,
    required this.label,
    required this.count,
    required this.max,
  });

  final String label;
  final int count;
  final int max;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ratio = max == 0 ? 0.0 : count / max;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: scheme.onSurface)),
            Text('$count', style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 10,
            backgroundColor: scheme.surface.withValues(alpha: 0.45),
            color: scheme.primary,
          ),
        ),
      ],
    );
  }
}
