import 'package:flutter/material.dart';
import 'package:notch_app/features/insights/services/insights_view_model.dart';

class InsightsHero extends StatelessWidget {
  const InsightsHero({super.key, required this.hero});

  final InsightsHeroData hero;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = _accent(scheme);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: 0.22),
            scheme.surfaceContainerHighest.withValues(alpha: 0.7),
            scheme.surface.withValues(alpha: 0.96),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: accent.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Chip(label: hero.eyebrow, accent: accent),
          const SizedBox(height: 18),
          Text(
            hero.title,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 30,
              fontWeight: FontWeight.w900,
              height: 0.95,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            hero.summary,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 15,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _Chip(label: hero.primaryChip, accent: accent),
              _Chip(label: hero.secondaryChip, accent: scheme.secondary),
            ],
          ),
        ],
      ),
    );
  }

  Color _accent(ColorScheme scheme) => switch (hero.tone) {
    InsightsTone.positive => scheme.tertiary,
    InsightsTone.caution => scheme.error,
    InsightsTone.neutral => scheme.primary,
  };
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.accent});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withValues(alpha: 0.18)),
      ),
      child: Text(
        label,
        style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700),
      ),
    );
  }
}
