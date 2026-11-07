import 'package:flutter/material.dart';

class SharePreviewStatRow extends StatelessWidget {
  const SharePreviewStatRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.compact = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final verticalPadding = compact ? 10.0 : 14.0;
    final tileSize = compact ? 34.0 : 42.0;
    final tileRadius = compact ? 12.0 : 14.0;
    final iconSize = compact ? 16.0 : 18.0;
    final labelSize = compact ? 12.0 : 14.0;
    final valueSize = compact ? 22.0 : 28.0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: verticalPadding),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: tileSize,
            height: tileSize,
            decoration: BoxDecoration(
              color: scheme.secondaryContainer.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(tileRadius),
            ),
            child: Icon(
              icon,
              color: scheme.onSecondaryContainer,
              size: iconSize,
            ),
          ),
          SizedBox(width: compact ? 12 : 14),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Lato',
                color: scheme.onSurface.withValues(alpha: 0.8),
                fontSize: labelSize,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
          SizedBox(width: compact ? 10 : 12),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'BebasNeue',
              color: scheme.onSurface,
              fontSize: valueSize,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
