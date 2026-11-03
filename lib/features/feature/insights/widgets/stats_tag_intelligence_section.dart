import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_tag_detail_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_section_title.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_tag_card.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_tag_detail_sheet.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsTagIntelligenceSection extends StatelessWidget {
  const StatsTagIntelligenceSection({
    super.key,
    required this.tags,
    required this.encounters,
  });

  final List<StatsTagInsight> tags;
  final List<Encounter> encounters;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsSectionTitle(l10n.statsTagIntelligenceTitle),
        const SizedBox(height: 16),
        ...tags.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: StatsTagCard(
              tag: entry.value,
              rank: entry.key + 1,
              onTap: () => showModalBottomSheet<void>(
                context: context,
                backgroundColor: Theme.of(context).colorScheme.surface,
                builder: (_) => StatsTagDetailSheet(
                  summary: StatsTagDetailService.build(
                    tagKey: entry.value.tagKey,
                    encounters: encounters,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
