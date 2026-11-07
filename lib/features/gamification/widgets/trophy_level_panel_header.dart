import 'package:flutter/material.dart';

class TrophyLevelPanelHeader extends StatelessWidget {
  const TrophyLevelPanelHeader({
    super.key,
    required this.title,
    required this.isCurrentMonth,
    required this.onShareTap,
  });

  final String title;
  final bool isCurrentMonth;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: scheme.scrim.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: scheme.onPrimary.withValues(alpha: 0.84),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.8,
            ),
          ),
        ),
        const Spacer(),
        if (isCurrentMonth)
          IconButton.filledTonal(
            onPressed: onShareTap,
            style: IconButton.styleFrom(
              backgroundColor: scheme.surface.withValues(alpha: 0.2),
              foregroundColor: scheme.onPrimary,
            ),
            icon: const Icon(Icons.ios_share_rounded, size: 20),
          ),
      ],
    );
  }
}
