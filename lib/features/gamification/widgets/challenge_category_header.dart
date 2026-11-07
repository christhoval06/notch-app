import 'package:flutter/material.dart';
import 'package:notch_app/features/gamification/services/challenge_category_service.dart';
import 'package:notch_app/features/gamification/services/challenges_view_model_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class ChallengeCategoryHeader extends StatelessWidget {
  const ChallengeCategoryHeader({
    super.key,
    required this.category,
    required this.challengeCount,
    required this.summary,
    required this.isExpanded,
    required this.onTap,
    required this.accent,
    required this.tint,
  });

  final ChallengeCategory category;
  final int challengeCount;
  final ChallengeCategorySummary summary;
  final bool isExpanded;
  final VoidCallback onTap;
  final Color accent;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: tint,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: accent.withValues(alpha: 0.18)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    ChallengeCategoryService.icon(category),
                    color: accent,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    ChallengeCategoryService.label(l10n, category),
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  '${summary.completedCount}/$challengeCount',
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  child: Icon(Icons.expand_more, color: accent),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 4,
                  height: 28,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: summary.completionRate,
                minHeight: 6,
                color: accent,
                backgroundColor: accent.withValues(alpha: 0.16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
