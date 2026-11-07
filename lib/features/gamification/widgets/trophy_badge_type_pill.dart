import 'package:flutter/material.dart';

class TrophyBadgeTypePill extends StatelessWidget {
  const TrophyBadgeTypePill({
    super.key,
    required this.label,
    required this.isUnlocked,
  });

  final String label;
  final bool isUnlocked;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: isUnlocked ? 0.72 : 0.58),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.9)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: scheme.onSurfaceVariant,
          fontSize: 8,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
