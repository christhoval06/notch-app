import 'package:flutter/material.dart';
import 'package:notch_app/core/constants/feature_flags.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/gamification/services/season_activity_metrics_service.dart';
import 'package:notch_app/features/feature/gamification/widgets/abstinence_records_card.dart';
import 'package:notch_app/features/feature/gamification/widgets/gamification_premium_intro.dart';
import 'package:notch_app/features/feature/gamification/widgets/gamification_premium_panel.dart';
import 'package:notch_app/features/feature/gamification/widgets/season_activity_rhythm_card.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_badges_panel.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_featured_challenge_card.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_level_panel.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_season_selector.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_streaks_section.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyRoomContent extends StatelessWidget {
  const TrophyRoomContent({
    super.key,
    required this.monthIds,
    required this.selectedMonthId,
    required this.onMonthChanged,
    required this.onLevelTap,
    required this.progress,
    required this.globalProgress,
    required this.monthlyEntries,
    required this.allEncounters,
    required this.isCurrentMonth,
    required this.currentStreak,
    required this.seasonBestStreak,
    required this.allTimeBestStreak,
    required this.seasonalAbstinenceRecord,
    required this.historicalAbstinenceRecord,
    required this.activityMetrics,
    required this.unlockedCount,
    required this.allCount,
    required this.onBadgeTap,
    required this.onShareTap,
  });

  final List<String> monthIds;
  final String? selectedMonthId;
  final ValueChanged<String> onMonthChanged;
  final VoidCallback onLevelTap;
  final MonthlyProgress progress;
  final GlobalProgress globalProgress;
  final Iterable<MonthlyProgress> monthlyEntries;
  final List<Encounter> allEncounters;
  final bool isCurrentMonth;
  final int currentStreak;
  final int seasonBestStreak;
  final int allTimeBestStreak;
  final int seasonalAbstinenceRecord;
  final int historicalAbstinenceRecord;
  final SeasonActivityMetrics activityMetrics;
  final int unlockedCount;
  final int allCount;
  final void Function(String, String, String, String, bool, bool, List<String>)
  onBadgeTap;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final isLiteMode = FeatureFlags.liteModeEnabled;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              scheme.surface,
              scheme.surfaceContainerHigh,
              scheme.surfaceContainerLowest,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GamificationPremiumIntro(
                title: l10n.homeTrophyRoomTitle,
                subtitle: l10n.trophyRoomSubtitle,
              ),
              const SizedBox(height: 25),
              GamificationPremiumPanel(
                child: Column(
                  children: [
                    TrophySeasonSelector(
                      monthIds: monthIds,
                      selectedMonthId: selectedMonthId,
                      onChanged: onMonthChanged,
                    ),
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: onLevelTap,
                      behavior: HitTestBehavior.opaque,
                      child: TrophyLevelPanel(
                        progress: progress,
                        isCurrentMonth: isCurrentMonth,
                        onShareTap: onShareTap,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              TrophyStreaksSection(
                currentStreak: currentStreak,
                seasonBestStreak: seasonBestStreak,
                allTimeBestStreak: allTimeBestStreak,
                showCurrentStreak: !isLiteMode,
              ),
              const SizedBox(height: 25),
              AbstinenceRecordsCard(
                seasonRecord: seasonalAbstinenceRecord,
                historicalRecord: historicalAbstinenceRecord,
              ),
              if (!isLiteMode) ...[
                const SizedBox(height: 25),
                SeasonActivityRhythmCard(metrics: activityMetrics),
                const SizedBox(height: 25),
                TrophyFeaturedChallengeCard(allEncounters: allEncounters),
                const SizedBox(height: 25),
              ],
              TrophyBadgesPanel(
                progress: progress,
                globalProgress: globalProgress,
                monthlyEntries: monthlyEntries,
                unlockedCount: unlockedCount,
                allCount: allCount,
                onBadgeTap: onBadgeTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
