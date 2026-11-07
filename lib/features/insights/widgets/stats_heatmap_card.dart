import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_heatmap_day_summary_service.dart';
import 'package:notch_app/features/insights/services/stats_heatmap_style_service.dart';
import 'package:notch_app/features/insights/services/stats_models.dart';
import 'package:notch_app/features/insights/services/stats_period_range_service.dart';
import 'package:notch_app/features/insights/widgets/stats_heatmap_day_sheet.dart';
import 'package:notch_app/features/insights/widgets/stats_heatmap_panel.dart';
import 'package:notch_app/features/insights/widgets/stats_section_title.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsHeatmapCard extends StatefulWidget {
  const StatsHeatmapCard({
    super.key,
    required this.encounters,
    required this.heatmapData,
    required this.period,
  });

  final List<Encounter> encounters;
  final Map<DateTime, int> heatmapData;
  final StatPeriod period;

  @override
  State<StatsHeatmapCard> createState() => _StatsHeatmapCardState();
}

class _StatsHeatmapCardState extends State<StatsHeatmapCard> {
  int? _selectedCount;
  DateTime? _selectedDate;

  @override
  void didUpdateWidget(covariant StatsHeatmapCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.period != widget.period) {
      setState(() {
        _selectedCount = null;
        _selectedDate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final baseRange = StatsPeriodRangeService.range(widget.period);
    final firstLoggedDate = widget.heatmapData.keys.isEmpty
        ? null
        : (widget.heatmapData.keys.toList()..sort()).first;
    final range = widget.period == StatPeriod.allTime && firstLoggedDate != null
        ? (start: DateTime(firstLoggedDate.year, firstLoggedDate.month, firstLoggedDate.day), end: baseRange.end)
        : baseRange;
    final data = {
      for (final entry in widget.heatmapData.entries)
        if (!entry.key.isBefore(range.start) && !entry.key.isAfter(range.end))
          DateTime(entry.key.year, entry.key.month, entry.key.day): entry.value,
    };
    final style = StatsHeatmapStyleService.build(
      data: data,
      scheme: scheme,
      selectedDate: _selectedDate,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsSectionTitle(l10n.statsActivityMapTitle),
        const SizedBox(height: 8),
        Text(
          l10n.statsActivityMapSummary(data.length.toString()),
          style: TextStyle(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 20),
        StatsHeatmapPanel(
          periodKey: widget.period,
          startDate: range.start,
          endDate: range.end,
          data: style.data,
          colorsets: style.colorsets,
          textColor: scheme.onSurface,
          surfaceColor: scheme.surface,
          borderColor: scheme.outlineVariant.withValues(alpha: 0.3),
          selectedDate: _selectedDate,
          selectedCount: _selectedCount,
          onTap: (date) {
            final normalized = DateTime(date.year, date.month, date.day);
            final count = data[normalized] ?? 0;
            if (count == 0) {
              setState(() {
                _selectedCount = null;
                _selectedDate = null;
              });
              return;
            }
            setState(() {
              _selectedCount = count;
              _selectedDate = normalized;
            });
            final dayEncounters = widget.encounters
                .where((item) => _sameDay(item.date, normalized))
                .toList();
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: scheme.surface,
              builder: (_) => StatsHeatmapDaySheet(
                title: l10n.statsActivityMapTitle,
                date: normalized,
                count: count,
                summary: StatsHeatmapDaySummaryService.build(dayEncounters),
                encounters: dayEncounters,
              ),
            );
          },
        ),
      ],
    );
  }

  bool _sameDay(DateTime value, DateTime target) {
    return value.year == target.year &&
        value.month == target.month &&
        value.day == target.day;
  }
}
