import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/professional_bottom_sheet.dart';
import 'package:notch_app/features/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/insights/widgets/stats_partner_context_chips.dart';
import 'package:notch_app/features/insights/widgets/stats_partner_detail_metrics.dart';
import 'package:notch_app/features/insights/widgets/stats_partner_recent_encounters.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsPartnerDetailSheet extends StatelessWidget {
  const StatsPartnerDetailSheet({
    super.key,
    required this.summary,
    required this.badgeLabel,
    required this.badge,
  });

  final StatsPartnerDetailSummary summary;
  final String badgeLabel;
  final StatsPartnerBadge? badge;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return ProfessionalBottomSheet(
      title: summary.partnerName,
      subtitle: _subtitle(l10n),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scheme.surfaceContainerHighest, scheme.primaryContainer.withValues(alpha: 0.35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(badgeLabel, style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(_insight(l10n), style: TextStyle(color: scheme.onSurfaceVariant, height: 1.35)),
            const SizedBox(height: 16),
            StatsPartnerDetailMetrics(summary: summary),
            const SizedBox(height: 16),
            StatsPartnerContextChips(summary: summary),
            const SizedBox(height: 18),
            StatsPartnerRecentEncounters(encounters: summary.recentEncounters),
          ],
        ),
      ),
    );
  }

  String _subtitle(AppLocalizations l10n) {
    switch (badge) {
      case StatsPartnerBadge.mostActive:
        return l10n.statsPartnerDetailMostActive;
      case StatsPartnerBadge.bestChemistry:
        return l10n.statsPartnerDetailBestChemistry;
      case StatsPartnerBadge.mostRecent:
        return l10n.statsPartnerDetailMostRecent;
      case null:
        return '';
    }
  }

  String _insight(AppLocalizations l10n) {
    if (summary.averageRating >= 9) {
      return l10n.statsPartnerInsightHighChemistry(summary.partnerName);
    }
    if (summary.protectionRate >= 0.8) {
      return l10n.statsPartnerInsightSafety(summary.partnerName);
    }
    return l10n.statsPartnerInsightMomentum(summary.partnerName);
  }
}
