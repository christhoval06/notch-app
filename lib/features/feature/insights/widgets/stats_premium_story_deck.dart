import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_premium_models.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_section_title.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsPremiumStoryDeck extends StatelessWidget {
  const StatsPremiumStoryDeck({super.key, required this.stories});

  final List<StatsPremiumMetricData> stories;

  @override
  Widget build(BuildContext context) {
    if (stories.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsSectionTitle(l10n.statsPremiumDeckTitle),
        const SizedBox(height: 14),
        ...stories.map(
          (story) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _StoryCard(story: story),
          ),
        ),
      ],
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({required this.story});

  final StatsPremiumMetricData story;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final accent = story.tone == StatsSignalTone.caution
        ? scheme.error
        : scheme.primary;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _label(l10n),
            style: TextStyle(color: accent, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            _headline(l10n),
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _supporting(l10n),
            style: TextStyle(color: scheme.onSurfaceVariant, height: 1.3),
          ),
        ],
      ),
    );
  }

  String _label(AppLocalizations l10n) => switch (story.id) {
    'quality' => l10n.statsPremiumStoryQuality,
    'protection' => l10n.statsPremiumStoryProtection,
    'partner_mode' => l10n.statsPremiumStoryPartner,
    'consistency' => l10n.statsPremiumStoryConsistency,
    _ => l10n.statsPremiumStoryRhythm,
  };

  String _headline(AppLocalizations l10n) => switch (story.id) {
    'quality' => l10n.statsPremiumStoryQualityHeadline(
      (story.currentValue as double).toStringAsFixed(1),
    ),
    'protection' => l10n.statsPremiumStoryProtectionHeadline(
      story.currentValue.round(),
    ),
    'partner_mode' => l10n.statsPremiumStoryPartnerHeadline(
      story.contextLabel ?? l10n.statsPremiumUnknownPartner,
    ),
    'consistency' => l10n.statsPremiumStoryConsistencyHeadline(
      story.currentValue.round(),
    ),
    _ => l10n.statsPremiumStoryRhythmHeadline(_bucketLabel(l10n)),
  };

  String _supporting(AppLocalizations l10n) => switch (story.id) {
    'quality' => l10n.statsPremiumStoryQualityBody,
    'protection' => l10n.statsPremiumStoryProtectionBody,
    'partner_mode' => l10n.statsPremiumStoryPartnerBody(
      story.auxiliaryValue?.round() ?? 0,
    ),
    'consistency' => l10n.statsPremiumStoryConsistencyBody(
      story.auxiliaryValue?.round() ?? 0,
    ),
    _ => l10n.statsPremiumStoryRhythmBody(story.auxiliaryValue?.round() ?? 0),
  };

  String _bucketLabel(AppLocalizations l10n) => switch (story.contextLabel) {
    'morning' => l10n.statsFilterMorning,
    'afternoon' => l10n.statsFilterAfternoon,
    _ => l10n.statsFilterNight,
  };
}
