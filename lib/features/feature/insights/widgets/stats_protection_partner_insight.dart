import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/features/feature/insights/services/stats_protection_detail_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsProtectionPartnerInsight extends StatelessWidget {
  const StatsProtectionPartnerInsight({super.key, required this.summary});

  final StatsProtectionDetailSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final scheme = Theme.of(context).colorScheme;
    final date = summary.lastUnprotectedDate == null
        ? '-'
        : DateFormat('d MMM y', locale).format(summary.lastUnprotectedDate!);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.statsProtectionTopRiskPartnerLabel, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
          const SizedBox(height: 4),
          Text(summary.topRiskPartnerName ?? '-', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          Text('${l10n.statsLastUnprotectedDateLabel}: $date', style: TextStyle(color: scheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
