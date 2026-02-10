import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import '../models/challenge.dart';
import '../models/encounter.dart';
import '../services/challenge_service.dart';

class ChallengesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "${l10n.challengesTitle} 💪",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Encounter>('encounters').listenable(),
        builder: (context, Box<Encounter> box, _) {
          final challenges = ChallengeService.getChallengesWithProgress();
          final allEncounters = box.values.toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.challengesSubtitle,
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: challenges.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final challenge = challenges[index];
                    return _buildChallengeCard(
                      context,
                      challenge,
                      allEncounters,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChallengeCard(
    BuildContext context,
    Challenge challenge,
    List<Encounter> allEncounters,
  ) {
    final l10n = AppLocalizations.of(context);
    final progress = challenge.getProgress(allEncounters);
    final progressPercent = challenge.getProgressPercent(allEncounters);
    final isCompleted = progressPercent >= 1.0;

    String progressText;
    if (challenge.id == 'legendary_guardian') {
      progressText = "${progress.toStringAsFixed(0)}% / ${challenge.goal}%";
    } else {
      progressText = "${progress.toInt()} / ${challenge.goal}";
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green.withOpacity(0.1) : Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isCompleted ? Colors.green : Colors.grey[800]!,
          width: isCompleted ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                challenge.icon,
                color: isCompleted ? Colors.green : Colors.blueAccent,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _challengeTitle(l10n, challenge.id),
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isCompleted)
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _challengeDescription(l10n, challenge.id),
            style: TextStyle(color: Colors.grey[400], fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progressPercent,
                    minHeight: 10,
                    backgroundColor: Colors.black26,
                    color: isCompleted ? Colors.green : Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                progressText,
                style: TextStyle(
                  color: isCompleted ? Colors.green : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _challengeTitle(AppLocalizations l10n, String id) {
    switch (id) {
      case 'morning_master':
        return l10n.challengeMorningMasterTitle;
      case 'weekly_explorer':
        return l10n.challengeWeeklyExplorerTitle;
      case 'quality_week':
        return l10n.challengeQualityWeekTitle;
      case 'safety_champion':
        return l10n.challengeSafetyChampionTitle;
      case 'prelude_master':
        return l10n.challengePreludeMasterTitle;
      case 'steel_consistency':
        return l10n.challengeSteelConsistencyTitle;
      case 'quality_club':
        return l10n.challengeQualityClubTitle;
      case 'guardian_of_safety':
        return l10n.challengeGuardianOfSafetyTitle;
      case 'perfect_weekend':
        return l10n.challengePerfectWeekendTitle;
      case 'epic_morning':
        return l10n.challengeEpicMorningTitle;
      case 'frequent_flyer':
        return l10n.challengeFrequentFlyerTitle;
      case 'star_collector':
        return l10n.challengeStarCollectorTitle;
      case 'centurion':
        return l10n.challengeCenturionTitle;
      case 'legendary_guardian':
        return l10n.challengeLegendaryGuardianTitle;
      case 'polymath':
        return l10n.challengePolymathTitle;
      default:
        return id;
    }
  }

  String _challengeDescription(AppLocalizations l10n, String id) {
    switch (id) {
      case 'morning_master':
        return l10n.challengeMorningMasterDesc;
      case 'weekly_explorer':
        return l10n.challengeWeeklyExplorerDesc;
      case 'quality_week':
        return l10n.challengeQualityWeekDesc;
      case 'safety_champion':
        return l10n.challengeSafetyChampionDesc;
      case 'prelude_master':
        return l10n.challengePreludeMasterDesc;
      case 'steel_consistency':
        return l10n.challengeSteelConsistencyDesc;
      case 'quality_club':
        return l10n.challengeQualityClubDesc;
      case 'guardian_of_safety':
        return l10n.challengeGuardianOfSafetyDesc;
      case 'perfect_weekend':
        return l10n.challengePerfectWeekendDesc;
      case 'epic_morning':
        return l10n.challengeEpicMorningDesc;
      case 'frequent_flyer':
        return l10n.challengeFrequentFlyerDesc;
      case 'star_collector':
        return l10n.challengeStarCollectorDesc;
      case 'centurion':
        return l10n.challengeCenturionDesc;
      case 'legendary_guardian':
        return l10n.challengeLegendaryGuardianDesc;
      case 'polymath':
        return l10n.challengePolymathDesc;
      default:
        return id;
    }
  }
}
