import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/professional_bottom_sheet.dart';
import 'package:notch_app/features/feature/insights/services/stats_story_copy_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_story_service.dart';

class StatsStorySheet extends StatelessWidget {
  const StatsStorySheet({
    super.key,
    required this.presentation,
    required this.tone,
  });

  final StatsStoryPresentation presentation;
  final StatsStoryTone tone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = switch (tone) {
      StatsStoryTone.positive => scheme.tertiary,
      StatsStoryTone.caution => scheme.error,
      StatsStoryTone.neutral => scheme.primary,
    };
    return ProfessionalBottomSheet(
      title: presentation.title,
      subtitle: presentation.headline,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              presentation.supporting,
              style: TextStyle(color: accent, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Text(
              presentation.details,
              style: TextStyle(color: scheme.onSurfaceVariant, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
