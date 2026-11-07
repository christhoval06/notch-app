import 'package:flutter/material.dart';
import 'package:notch_app/features/gamification/services/achievement_ui.dart';

class AchievementBadgeFace extends StatelessWidget {
  const AchievementBadgeFace({
    super.key,
    required this.id,
    required this.icon,
    required this.isUnlocked,
    required this.size,
  });

  final String id;
  final String icon;
  final bool isUnlocked;
  final double size;

  static const grayscaleMatrix = <double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ColorFiltered(
      colorFilter: isUnlocked
          ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
          : const ColorFilter.matrix(grayscaleMatrix),
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              scheme.secondary.withValues(alpha: isUnlocked ? 0.48 : 0.16),
              scheme.surfaceBright,
              scheme.surfaceDim,
            ],
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: id.achievementGradient,
            border: Border.all(
              color: scheme.onSurface.withValues(
                alpha: isUnlocked ? 0.22 : 0.1,
              ),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withValues(
                  alpha: isUnlocked ? 0.24 : 0.12,
                ),
                blurRadius: 14,
                spreadRadius: -3,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: size * 0.1,
                child: Container(
                  width: size * 0.54,
                  height: size * 0.16,
                  decoration: BoxDecoration(
                    color: scheme.onSurface.withValues(
                      alpha: isUnlocked ? 0.18 : 0.08,
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Container(
                width: size * 0.72,
                height: size * 0.72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: scheme.surface.withValues(alpha: 0.22),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size * 0.02),
                child: Text(
                  icon,
                  style: TextStyle(
                    fontSize: size * 0.4,
                    color: scheme.onPrimary.withValues(
                      alpha: isUnlocked ? 0.98 : 0.62,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
