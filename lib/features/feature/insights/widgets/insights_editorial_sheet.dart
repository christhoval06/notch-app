import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/professional_bottom_sheet.dart';
import 'package:notch_app/features/feature/insights/services/insights_view_model.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class InsightsEditorialSheet extends StatelessWidget {
  const InsightsEditorialSheet({super.key, required this.block});

  final InsightsEditorialBlockData block;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final accent = switch (block.tone) {
      InsightsTone.positive => scheme.tertiary,
      InsightsTone.caution => scheme.error,
      InsightsTone.neutral => scheme.primary,
    };
    return ProfessionalBottomSheet(
      title: block.label,
      subtitle: block.headline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              block.detail,
              style: TextStyle(color: scheme.onSurfaceVariant, height: 1.4),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accent.withValues(alpha: 0.18)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.insightsSheetRecommendation,
                  style: TextStyle(color: accent, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  block.recommendation,
                  style: TextStyle(color: scheme.onSurface, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
