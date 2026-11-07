import 'package:flutter/material.dart';

class SharePreviewProgressBar extends StatelessWidget {
  const SharePreviewProgressBar({
    super.key,
    required this.label,
    required this.progress,
    this.compact = false,
    this.dense = false,
  });

  final String label;
  final double progress;
  final bool compact;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final value = progress.clamp(0.0, 1.0);
    final percent = '${(value * 100).round()}%';
    final padding = dense ? 10.0 : (compact ? 12.0 : 16.0);
    final labelSize = dense ? 10.0 : (compact ? 11.0 : 12.0);
    final valueSize = dense ? 16.0 : (compact ? 18.0 : 22.0);
    final spacing = dense ? 6.0 : (compact ? 8.0 : 12.0);
    final barHeight = dense ? 6.0 : (compact ? 8.0 : 10.0);
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: scheme.onSurface.withValues(alpha: 0.74),
                    fontSize: labelSize,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              Text(
                percent,
                style: TextStyle(
                  fontFamily: 'BebasNeue',
                  color: scheme.onSurface,
                  fontSize: valueSize,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              minHeight: barHeight,
              value: value,
              backgroundColor: scheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation(scheme.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
