import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsHeatmapSelectionLabel extends StatelessWidget {
  const StatsHeatmapSelectionLabel({
    super.key,
    required this.date,
    required this.count,
  });

  final DateTime date;
  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final formattedDate = DateFormat.yMMMd(locale).format(date);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formattedDate,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: scheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          l10n.statsHeatmapSelectionCount(count.toString()),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
