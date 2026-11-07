import 'package:flutter/material.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/gamification/presentation/pages/challenges_page.dart';
import 'package:notch_app/features/gamification/services/challenge_service.dart';
import 'package:notch_app/features/gamification/services/challenge_title_service.dart';
import 'package:notch_app/features/gamification/widgets/challenge_meta_row.dart';
import 'package:notch_app/features/gamification/widgets/trophy_empty_challenge_content.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyFeaturedChallengeCard extends StatelessWidget {
  const TrophyFeaturedChallengeCard({super.key, required this.allEncounters});

  final List<Encounter> allEncounters;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final featuredChallenge = ChallengeService.getFeaturedChallenge();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ChallengesScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: scheme.secondary.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.track_changes, color: scheme.secondary),
                const SizedBox(width: 10),
                Text(
                  l10n.trophyActiveChallenges,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: scheme.secondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: scheme.onSurfaceVariant,
                  size: 14,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (featuredChallenge != null)
              _ActiveChallengeContent(
                challenge: featuredChallenge,
                allEncounters: allEncounters,
              )
            else
              const TrophyEmptyChallengeContent(),
          ],
        ),
      ),
    );
  }
}

class _ActiveChallengeContent extends StatelessWidget {
  const _ActiveChallengeContent({
    required this.challenge,
    required this.allEncounters,
  });

  final Challenge challenge;
  final List<Encounter> allEncounters;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final progress = challenge.getProgress(allEncounters);
    final progressPercent = challenge.getProgressPercent(allEncounters);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ChallengeTitleService.localize(l10n, challenge.id),
          style: TextStyle(
            color: scheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        ChallengeMetaRow(challenge: challenge, highlighted: true),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progressPercent,
                  minHeight: 8,
                  backgroundColor: scheme.scrim.withValues(alpha: 0.26),
                  color: scheme.secondary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${progress.toInt()} / ${challenge.goal}',
              style: TextStyle(
                color: scheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
