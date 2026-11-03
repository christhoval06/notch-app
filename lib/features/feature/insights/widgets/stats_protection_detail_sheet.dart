import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/professional_bottom_sheet.dart';
import 'package:notch_app/features/feature/insights/services/stats_protection_detail_models.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_protection_detail_metrics.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_protection_partner_insight.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_protection_recent_encounters.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsProtectionDetailSheet extends StatelessWidget {
  const StatsProtectionDetailSheet({super.key, required this.summary});

  final StatsProtectionDetailSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return ProfessionalBottomSheet(
      title: l10n.statsProtectionTitle,
      subtitle: l10n.statsProtectionDetailSubtitle,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scheme.surfaceContainerHighest, scheme.tertiaryContainer.withValues(alpha: 0.35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.statsProtectionInsightBody, style: TextStyle(color: scheme.onSurfaceVariant, height: 1.35)),
            const SizedBox(height: 16),
            StatsProtectionDetailMetrics(summary: summary),
            const SizedBox(height: 16),
            StatsProtectionPartnerInsight(summary: summary),
            const SizedBox(height: 18),
            StatsProtectionRecentEncounters(encounters: summary.recentUnprotectedEncounters),
          ],
        ),
      ),
    );
  }
}
