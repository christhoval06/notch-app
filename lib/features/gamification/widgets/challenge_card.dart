import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/gamification/services/challenge_description_service.dart';
import 'package:notch_app/features/gamification/services/challenge_title_service.dart';
import 'package:notch_app/features/gamification/services/challenges_view_model_service.dart';
import 'package:notch_app/features/gamification/widgets/challenge_meta_row.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({
    super.key,
    required this.challenge,
    required this.encounters,
  });

  final Challenge challenge;
  final List<Encounter> encounters;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final viewModel = ChallengesViewModelService.build(challenge, encounters);
    final accent = viewModel.isCompleted ? scheme.success : scheme.primary;
    return Container(
      padding: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: 0.42),
            scheme.surfaceContainerHighest,
            scheme.surfaceContainerLow,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: scheme.surfaceContainer.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: accent.withValues(alpha: viewModel.isCompleted ? 0.6 : 0.22),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(challenge.icon, color: accent, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    ChallengeTitleService.localize(l10n, challenge.id),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: scheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (viewModel.isCompleted)
                  Icon(Icons.verified_rounded, color: scheme.success, size: 20),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              ChallengeDescriptionService.localize(l10n, challenge.id),
              style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
            ),
            const SizedBox(height: 14),
            ChallengeMetaRow(
              challenge: challenge,
              highlighted: viewModel.isCompleted,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: viewModel.progressPercent,
                      minHeight: 11,
                      backgroundColor: scheme.scrim.withValues(alpha: 0.22),
                      color: accent,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    viewModel.progressText,
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
