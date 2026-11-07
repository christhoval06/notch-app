import 'package:flutter/material.dart';
import 'package:notch_app/features/insights/services/stats_comparison_copy_service.dart';
import 'package:notch_app/features/insights/services/stats_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsComparisonSummary extends StatelessWidget {
  const StatsComparisonSummary({super.key, required this.state});

  final StatsComparisonState state;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = switch (state) {
      StatsComparisonState.up => scheme.tertiary,
      StatsComparisonState.down => scheme.error,
      StatsComparisonState.stable => scheme.primary,
      StatsComparisonState.baseline => scheme.primary,
    };
    final message = StatsComparisonCopyService.message(
      AppLocalizations.of(context),
      state,
    );
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
