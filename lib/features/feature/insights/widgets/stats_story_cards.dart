import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_story_copy_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_story_service.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_section_title.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_story_sheet.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsStoryCards extends StatelessWidget {
  const StatsStoryCards({super.key, required this.cards});

  final List<StatsStoryCardData> cards;

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsSectionTitle(l10n.insightsTitle),
        const SizedBox(height: 16),
        ...cards.map((card) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _StoryCard(card: card),
            )),
      ],
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({required this.card});

  final StatsStoryCardData card;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = switch (card.tone) {
      StatsStoryTone.positive => scheme.tertiary,
      StatsStoryTone.caution => scheme.error,
      StatsStoryTone.neutral => scheme.primary,
    };
    final l10n = AppLocalizations.of(context);
    final presentation = StatsStoryCopyService.present(
      l10n,
      card,
      Localizations.localeOf(context).toString(),
    );
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => showModalBottomSheet<void>(
          context: context,
          backgroundColor: scheme.surface,
          isScrollControlled: true,
          builder: (_) => StatsStorySheet(
            presentation: presentation,
            tone: card.tone,
          ),
        ),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                scheme.surface,
                accent.withValues(alpha: 0.08),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accent.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                presentation.title,
                style: TextStyle(color: accent, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                presentation.headline,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                presentation.supporting,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
