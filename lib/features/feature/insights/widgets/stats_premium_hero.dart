import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/features/feature/insights/services/stats_premium_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsPremiumHero extends StatelessWidget {
  const StatsPremiumHero({super.key, required this.hero});

  final StatsPremiumMetricData hero;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            scheme.primary.withValues(alpha: 0.28),
            scheme.tertiary.withValues(alpha: 0.18),
            scheme.surfaceContainerHighest.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              l10n.statsPremiumHeroEyebrow,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            _title(l10n),
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _body(l10n),
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 15,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _Chip(label: l10n.statsPremiumSignalScore(hero.score.round())),
              _Chip(label: _trendLabel(l10n)),
            ],
          ),
        ],
      ),
    );
  }

  String _title(AppLocalizations l10n) => switch (hero.id) {
    'quality' => l10n.statsPremiumHeroQualityTitle,
    'protection' => l10n.statsPremiumHeroProtectionTitle,
    'partner_mode' => l10n.statsPremiumHeroPartnerTitle,
    'consistency' => l10n.statsPremiumHeroConsistencyTitle,
    _ => l10n.statsPremiumHeroRhythmTitle,
  };

  String _body(AppLocalizations l10n) => switch (hero.id) {
    'quality' => l10n.statsPremiumHeroQualityBody(
      (hero.currentValue as double).toStringAsFixed(1),
    ),
    'protection' => l10n.statsPremiumHeroProtectionBody(
      hero.currentValue.round(),
    ),
    'partner_mode' => l10n.statsPremiumHeroPartnerBody(
      hero.contextLabel ?? l10n.statsPremiumUnknownPartner,
      hero.auxiliaryValue?.round() ?? 0,
    ),
    'consistency' => l10n.statsPremiumHeroConsistencyBody(
      hero.currentValue.round(),
      hero.auxiliaryValue?.round() ?? 0,
    ),
    _ => l10n.statsPremiumHeroRhythmBody(
      _bucketLabel(l10n, hero.contextLabel),
      hero.currentValue.round(),
    ),
  };

  String _trendLabel(AppLocalizations l10n) => switch (hero.trend) {
    StatsTrend.up => l10n.statsPremiumTrendUp,
    StatsTrend.down => l10n.statsPremiumTrendDown,
    StatsTrend.neutral => l10n.statsPremiumTrendStable,
  };

  String _bucketLabel(AppLocalizations l10n, String? bucket) =>
      switch (bucket) {
        'morning' => l10n.statsFilterMorning,
        'afternoon' => l10n.statsFilterAfternoon,
        _ => l10n.statsFilterNight,
      };
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700),
      ),
    );
  }
}
