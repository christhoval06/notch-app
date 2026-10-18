import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_badge_status_pill.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyBadgeInfoHeader extends StatelessWidget {
  const TrophyBadgeInfoHeader({
    super.key,
    required this.gradient,
    required this.icon,
    required this.name,
    required this.description,
    required this.isUnlocked,
    required this.isSeasonal,
  });

  final Gradient gradient;
  final String icon;
  final String name;
  final String description;
  final bool isUnlocked;
  final bool isSeasonal;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final narrow = MediaQuery.sizeOf(context).width < 390;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              TrophyBadgeStatusPill(
                label: isSeasonal
                    ? l10n.challengeSeasonal
                    : l10n.challengeHistorical,
                icon: isSeasonal ? Icons.calendar_month_rounded : Icons.history,
              ),
              TrophyBadgeStatusPill(
                label: isUnlocked
                    ? l10n.trophyBadgeStatusUnlocked
                    : l10n.trophyBadgeStatusLocked,
                icon: isUnlocked ? Icons.workspace_premium : Icons.lock_rounded,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Flex(
            direction: narrow ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: narrow
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              _BadgeIcon(icon: icon),
              SizedBox(width: narrow ? 0 : 16, height: narrow ? 14 : 0),
              Expanded(
                flex: narrow ? 0 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.12)),
          const SizedBox(height: 12),
          Text(
            l10n.trophyBadgeModalFootnote,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.74),
              fontSize: 12,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeIcon extends StatelessWidget {
  const _BadgeIcon({required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86,
      height: 86,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.34)),
      ),
      child: Container(
        width: 70,
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.1),
          border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
        ),
        child: Text(icon, style: const TextStyle(fontSize: 34)),
      ),
    );
  }
}
