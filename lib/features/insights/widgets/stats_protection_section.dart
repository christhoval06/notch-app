import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_protection_detail_service.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/features/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/insights/services/stats_rhythm_copy_service.dart';
import 'package:notch_app/features/insights/widgets/stats_protection_detail_sheet.dart';
import 'package:notch_app/features/insights/widgets/stats_protection_gauge.dart';
import 'package:notch_app/features/insights/widgets/stats_section_title.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsProtectionSection extends StatelessWidget {
  const StatsProtectionSection({
    super.key,
    required this.summary,
    required this.encounters,
  });

  final StatsProtectionSummary summary;
  final List<Encounter> encounters;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsSectionTitle(l10n.statsProtectionTitle),
        const SizedBox(height: 16),
        InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => showModalBottomSheet<void>(
            context: context,
            backgroundColor: scheme.surface,
            builder: (_) => StatsProtectionDetailSheet(
              summary: StatsProtectionDetailService.build(encounters: encounters),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [scheme.surface, scheme.tertiaryContainer.withValues(alpha: 0.35)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.35)),
            ),
            child: Column(
              children: [
                StatsProtectionGauge(
                  value: summary.protectionRate,
                  label: l10n.statsProtectionRateLabel,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _CountCard(
                        label: l10n.statsFilterProtected,
                        value: '${summary.protectedCount}',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _CountCard(
                        label: l10n.statsFilterUnprotected,
                        value: '${summary.unprotectedCount}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: scheme.surface.withValues(alpha: 0.78),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StatsRhythmCopyService.protectionTone(l10n, summary.tone),
                        style: TextStyle(
                          color: scheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${l10n.statsLastUnprotectedPartnerLabel}: ${summary.lastUnprotectedPartnerName ?? '-'}',
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${l10n.statsLastUnprotectedDateLabel}: ${summary.lastUnprotectedDate == null ? '-' : DateFormat('d MMM y', locale).format(summary.lastUnprotectedDate!)}',
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CountCard extends StatelessWidget {
  const _CountCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
