import 'package:flutter/material.dart';

class AchievementBadgeHalo extends StatelessWidget {
  const AchievementBadgeHalo({
    super.key,
    required this.size,
    required this.isUnlocked,
  });

  final double size;
  final bool isUnlocked;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: size + 12,
          height: size + 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                scheme.surfaceBright.withValues(
                  alpha: isUnlocked ? 0.95 : 0.72,
                ),
                scheme.surfaceDim.withValues(alpha: isUnlocked ? 0.92 : 0.68),
              ],
            ),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withValues(
                  alpha: isUnlocked ? 0.24 : 0.12,
                ),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
        ),
        Positioned(
          top: 7,
          child: Container(
            width: size * 0.56,
            height: size * 0.18,
            decoration: BoxDecoration(
              color: scheme.onSurface.withValues(
                alpha: isUnlocked ? 0.18 : 0.08,
              ),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
        if (!isUnlocked)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.3,
              height: size * 0.3,
              decoration: BoxDecoration(
                color: scheme.scrim.withValues(alpha: 0.72),
                shape: BoxShape.circle,
                border: Border.all(
                  color: scheme.outlineVariant.withValues(alpha: 0.75),
                ),
              ),
              child: Icon(
                Icons.lock_rounded,
                size: size * 0.15,
                color: scheme.onSurface.withValues(alpha: 0.92),
              ),
            ),
          ),
      ],
    );
  }
}
