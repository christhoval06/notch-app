import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/gamification/widgets/achievement_badge_face.dart';
import 'package:notch_app/features/feature/gamification/widgets/achievement_badge_halo.dart';

class AchievementBadge extends StatelessWidget {
  const AchievementBadge({
    super.key,
    required this.id,
    required this.icon,
    required this.name,
    required this.isUnlocked,
    this.size = 80,
    this.onTap,
  });

  final String id;
  final String icon;
  final String name;
  final bool isUnlocked;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: name,
      button: onTap != null,
      child: GestureDetector(
        onTap: onTap,
        child: Tooltip(
          message: name,
          preferBelow: true,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              AchievementBadgeHalo(size: size, isUnlocked: isUnlocked),
              AchievementBadgeFace(
                id: id,
                icon: icon,
                isUnlocked: isUnlocked,
                size: size,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
