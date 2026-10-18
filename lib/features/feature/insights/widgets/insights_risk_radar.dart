import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/insights_view_model.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class InsightsRiskRadar extends StatelessWidget {
  const InsightsRiskRadar({super.key, required this.signals});

  final List<InsightsRiskSignalData> signals;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.insightsRiskRadarTitle.toUpperCase(),
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 14),
          ...signals.map(
            (signal) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _SignalTile(signal: signal),
            ),
          ),
        ],
      ),
    );
  }
}

class _SignalTile extends StatelessWidget {
  const _SignalTile({required this.signal});

  final InsightsRiskSignalData signal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = switch (signal.tone) {
      InsightsTone.positive => scheme.tertiary,
      InsightsTone.caution => scheme.error,
      InsightsTone.neutral => scheme.primary,
    };
    return Row(
      children: [
        Expanded(
          child: Text(
            signal.label,
            style: TextStyle(
              color: scheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            signal.value,
            style: TextStyle(color: accent, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
