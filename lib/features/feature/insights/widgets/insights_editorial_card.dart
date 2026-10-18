import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/insights_view_model.dart';
import 'package:notch_app/features/feature/insights/widgets/insights_editorial_sheet.dart';

class InsightsEditorialCard extends StatelessWidget {
  const InsightsEditorialCard({super.key, required this.block});

  final InsightsEditorialBlockData block;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = _accent(scheme);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => showModalBottomSheet<void>(
          context: context,
          backgroundColor: scheme.surface,
          isScrollControlled: true,
          builder: (_) => InsightsEditorialSheet(block: block),
        ),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.34),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: accent.withValues(alpha: 0.18)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(block.icon, color: accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      block.label.toUpperCase(),
                      style: TextStyle(
                        color: accent,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      block.headline,
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      block.body,
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.chevron_right_rounded, color: accent),
            ],
          ),
        ),
      ),
    );
  }

  Color _accent(ColorScheme scheme) => switch (block.tone) {
    InsightsTone.positive => scheme.tertiary,
    InsightsTone.caution => scheme.error,
    InsightsTone.neutral => scheme.primary,
  };
}
