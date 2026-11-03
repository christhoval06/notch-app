import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_rhythm_copy_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsRhythmWeekdayBreakdown extends StatelessWidget {
  const StatsRhythmWeekdayBreakdown({super.key, required this.weekdayCounts});

  final Map<int, int> weekdayCounts;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final sorted = weekdayCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final max = sorted.isEmpty ? 1 : sorted.first.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.statsRhythmWeeklyPulseLabel,
          style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: sorted.map((entry) {
            final label = StatsRhythmCopyService.weekdayLabel(l10n, entry.key);
            final isTop = entry.value == max;
            return _WeekdayPill(
              label: label,
              shortLabel: label.substring(0, label.length >= 3 ? 3 : label.length),
              value: entry.value,
              isTop: isTop,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _WeekdayPill extends StatelessWidget {
  const _WeekdayPill({
    required this.label,
    required this.shortLabel,
    required this.value,
    required this.isTop,
  });

  final String label;
  final String shortLabel;
  final int value;
  final bool isTop;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final background = isTop
        ? scheme.primary.withValues(alpha: 0.16)
        : scheme.surface.withValues(alpha: 0.68);
    final borderColor = isTop
        ? scheme.primary.withValues(alpha: 0.32)
        : scheme.outlineVariant.withValues(alpha: 0.22);
    final labelColor = isTop ? scheme.primary : scheme.onSurfaceVariant;
    return Tooltip(
      message: label,
      child: Container(
        width: 78,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          children: [
            Text(
              shortLabel,
              style: TextStyle(
                color: labelColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '$value',
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
