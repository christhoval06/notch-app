import 'package:flutter/material.dart';
import 'package:notch_app/features/insights/services/stats_models.dart';
import 'package:notch_app/features/insights/services/stats_premium_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsSignalCard extends StatelessWidget {
  const StatsSignalCard({super.key, required this.signal});

  final StatsPremiumMetricData signal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final accent = _accent(scheme);
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.42),
        border: Border.all(color: accent.withValues(alpha: 0.26)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _label(l10n),
            style: TextStyle(color: accent, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Text(
            _headline(l10n),
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              height: 1.15,
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

  Color _accent(ColorScheme scheme) => switch (signal.tone) {
    StatsSignalTone.strong => scheme.tertiary,
    StatsSignalTone.caution => scheme.error,
    StatsSignalTone.balanced => scheme.primary,
  };

  String _label(AppLocalizations l10n) => switch (signal.id) {
    'consistency' => l10n.statsPremiumConsistencyTitle,
    'quality' => l10n.statsPremiumQualityTitle,
    _ => l10n.statsPremiumPartnerTitle,
  };

  String _headline(AppLocalizations l10n) => switch (signal.id) {
    'consistency' => l10n.statsPremiumConsistencyHeadline(
      signal.currentValue.round(),
      signal.auxiliaryValue?.round() ?? 0,
    ),
    'quality' => l10n.statsPremiumQualityHeadline(
      (signal.currentValue as double).toStringAsFixed(1),
    ),
    _ => l10n.statsPremiumPartnerHeadline(
      signal.currentValue.round(),
      signal.auxiliaryValue?.round() ?? 0,
    ),
  };

  String _supporting(AppLocalizations l10n) {
    final trend = switch (signal.trend) {
      StatsTrend.up => l10n.statsPremiumTrendUp,
      StatsTrend.down => l10n.statsPremiumTrendDown,
      StatsTrend.neutral => l10n.statsPremiumTrendStable,
    };
    if (signal.id == 'partner_mode' && signal.contextLabel != null) {
      return l10n.statsPremiumPartnerSupporting(signal.contextLabel!, trend);
    }
    return l10n.statsPremiumSignalSupporting(trend);
  }
}
