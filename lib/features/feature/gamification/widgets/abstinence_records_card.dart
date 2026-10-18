import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AbstinenceRecordsCard extends StatelessWidget {
  const AbstinenceRecordsCard({
    super.key,
    required this.seasonRecord,
    required this.historicalRecord,
  });

  final int seasonRecord;
  final int historicalRecord;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.trophyAbstinenceRecordsTitle,
            style: TextStyle(
              fontFamily: 'Lato',
              color: scheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.trophyAbstinenceRecordsSubtitle,
            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _RecordMetric(
                  label: l10n.trophyMonthRecord,
                  value: seasonRecord,
                  color: scheme.primary,
                  icon: Icons.calendar_month_rounded,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _RecordMetric(
                  label: l10n.trophyHistorical,
                  value: historicalRecord,
                  color: scheme.tertiary,
                  icon: Icons.workspace_premium_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecordMetric extends StatelessWidget {
  const _RecordMetric({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String label;
  final int value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.scrim.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$value ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: scheme.onSurface,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: l10n.trophyDays,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: scheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Lato',
              color: scheme.onSurfaceVariant,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
