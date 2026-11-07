import 'package:flutter/material.dart';
import 'package:notch_app/core/utils/translations.dart';
import 'package:notch_app/core/widgets/professional_bottom_sheet.dart';
import 'package:notch_app/features/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/insights/widgets/stats_tag_detail_metrics.dart';
import 'package:notch_app/features/insights/widgets/stats_tag_recent_encounters.dart';
import 'package:notch_app/features/insights/widgets/stats_tag_related_partners.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsTagDetailSheet extends StatelessWidget {
  const StatsTagDetailSheet({
    super.key,
    required this.summary,
  });

  final StatsTagDetailSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return ProfessionalBottomSheet(
      title: tagLabelFromL10n(l10n, summary.tagKey),
      subtitle: l10n.statsTagDetailSubtitle,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scheme.surfaceContainerHighest, scheme.secondaryContainer.withValues(alpha: 0.35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_insight(l10n), style: TextStyle(color: scheme.onSurfaceVariant, height: 1.35)),
            const SizedBox(height: 16),
            StatsTagDetailMetrics(summary: summary),
            const SizedBox(height: 16),
            Text(
              '${l10n.statsDominantMoodLabel}: ${summary.dominantMood ?? l10n.statsNoMoodLabel}',
              style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            StatsTagRelatedPartners(partners: summary.topPartners),
            const SizedBox(height: 18),
            StatsTagRecentEncounters(encounters: summary.recentEncounters),
          ],
        ),
      ),
    );
  }

  String _insight(AppLocalizations l10n) {
    if (summary.averageRating >= 9) {
      return l10n.statsTagInsightHighQuality(summary.topPartnerName);
    }
    if (summary.protectionRate >= 0.8) {
      return l10n.statsTagInsightSafe(summary.topPartnerName);
    }
    return l10n.statsTagInsightFrequent(summary.topPartnerName);
  }
}
