import 'package:flutter/material.dart';
import 'package:notch_app/features/gamification/widgets/achievement_badge.dart';
import 'package:notch_app/features/gamification/widgets/trophy_badge_type_pill.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyBadgeTile extends StatelessWidget {
  const TrophyBadgeTile({
    super.key,
    required this.id,
    required this.icon,
    required this.name,
    required this.isUnlocked,
    required this.isSeasonal,
    required this.onTap,
  });

  final String id;
  final String icon;
  final String name;
  final bool isUnlocked;
  final bool isSeasonal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final accent = isUnlocked ? scheme.secondary : scheme.outline;

    return LayoutBuilder(
      builder: (context, constraints) {
        final tight = constraints.maxWidth < 112;
        final badgeSize = tight ? 46.0 : 54.0;
        final sidePadding = tight ? 8.0 : 12.0;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onTap,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    scheme.surfaceContainerHighest,
                    scheme.surfaceContainer,
                  ],
                ),
                border: Border.all(
                  color: accent.withValues(alpha: isUnlocked ? 0.45 : 0.22),
                ),
                boxShadow: [
                  BoxShadow(
                    color: scheme.shadow.withValues(
                      alpha: isUnlocked ? 0.18 : 0.1,
                    ),
                    blurRadius: 22,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            scheme.onSurface.withValues(alpha: 0.08),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      sidePadding,
                      tight ? 8 : 10,
                      sidePadding,
                      tight ? 8 : 12,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TrophyBadgeTypePill(
                            label: isSeasonal
                                ? l10n.challengeSeasonal
                                : l10n.challengeHistorical,
                            isUnlocked: isUnlocked,
                          ),
                        ),
                        SizedBox(height: tight ? 6 : 10),
                        AchievementBadge(
                          id: id,
                          icon: icon,
                          name: name,
                          isUnlocked: isUnlocked,
                          size: badgeSize,
                        ),
                        SizedBox(height: tight ? 6 : 8),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isUnlocked
                                    ? scheme.onSurface
                                    : scheme.onSurfaceVariant,
                                fontWeight: FontWeight.w800,
                                fontSize: tight ? 10.8 : 11.8,
                                height: 1.08,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
