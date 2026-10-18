import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_category_service.dart';
import 'package:notch_app/features/feature/gamification/services/challenges_view_model_service.dart';
import 'package:notch_app/features/feature/gamification/widgets/challenge_card.dart';
import 'package:notch_app/features/feature/gamification/widgets/challenge_category_header.dart';

class ChallengeCategorySection extends StatelessWidget {
  const ChallengeCategorySection({
    super.key,
    required this.section,
    required this.encounters,
    required this.isExpanded,
    required this.onToggle,
  });

  final ChallengeCategorySectionModel section;
  final List<Encounter> encounters;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = _accentColor(scheme);
    final tint = _tintColor(scheme);
    final summary = ChallengesViewModelService.summarize(
      section.challenges,
      encounters,
    );
    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChallengeCategoryHeader(
            category: section.category,
            challengeCount: section.challenges.length,
            summary: summary,
            isExpanded: isExpanded,
            onTap: onToggle,
            accent: accent,
            tint: tint,
          ),
          if (isExpanded) ...[
            const SizedBox(height: 12),
            ...section.challenges.map(
              (challenge) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ChallengeCard(
                  challenge: challenge,
                  encounters: encounters,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _accentColor(ColorScheme scheme) {
    switch (section.category) {
      case ChallengeCategory.foundation:
        return scheme.primary;
      case ChallengeCategory.social:
        return scheme.secondary;
      case ChallengeCategory.events:
        return scheme.tertiary;
      case ChallengeCategory.relationships:
        return scheme.error;
      case ChallengeCategory.mood:
        return scheme.primaryFixed;
      case ChallengeCategory.skill:
        return scheme.secondaryFixed;
      case ChallengeCategory.legacy:
        return scheme.outline;
    }
  }

  Color _tintColor(ColorScheme scheme) {
    switch (section.category) {
      case ChallengeCategory.foundation:
        return scheme.primaryContainer.withValues(alpha: 0.3);
      case ChallengeCategory.social:
        return scheme.secondaryContainer.withValues(alpha: 0.3);
      case ChallengeCategory.events:
        return scheme.tertiaryContainer.withValues(alpha: 0.3);
      case ChallengeCategory.relationships:
        return scheme.errorContainer.withValues(alpha: 0.32);
      case ChallengeCategory.mood:
        return scheme.primaryFixedDim.withValues(alpha: 0.22);
      case ChallengeCategory.skill:
        return scheme.secondaryFixedDim.withValues(alpha: 0.22);
      case ChallengeCategory.legacy:
        return scheme.surfaceContainerHighest.withValues(alpha: 0.72);
    }
  }
}
