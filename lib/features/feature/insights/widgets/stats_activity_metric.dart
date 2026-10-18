import 'package:flutter/material.dart';

class StatsActivityMetric extends StatelessWidget {
  const StatsActivityMetric({
    super.key,
    required this.label,
    required this.value,
    this.detail,
  });

  final String label;
  final Widget value;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
        ),
        const SizedBox(height: 8),
        value,
        if (detail != null) ...[
          const SizedBox(height: 6),
          Text(
            detail!,
            textAlign: TextAlign.center,
            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11),
          ),
        ],
      ],
    );
  }
}
