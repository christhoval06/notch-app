import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsHeatmapDayEncounters extends StatefulWidget {
  const StatsHeatmapDayEncounters({
    super.key,
    required this.encounters,
  });

  final List<Encounter> encounters;

  @override
  State<StatsHeatmapDayEncounters> createState() =>
      _StatsHeatmapDayEncountersState();
}

class _StatsHeatmapDayEncountersState extends State<StatsHeatmapDayEncounters> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final visible = _expanded || widget.encounters.length <= 2
        ? widget.encounters
        : widget.encounters.take(2).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.statsEncountersLabel,
          style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        ...visible.map((encounter) {
          final protectionColor = encounter.protected ? scheme.tertiary : scheme.error;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text(
                  '${encounter.rating}',
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(encounter.partnerName, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat.jm(locale).format(encounter.date),
                        style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Text('${encounter.orgasmCount} ${l10n.orgasms}', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                const SizedBox(width: 10),
                Icon(
                  encounter.protected ? Icons.security : Icons.gpp_bad_outlined,
                  size: 16,
                  color: protectionColor,
                ),
              ],
            ),
          );
        }),
        if (widget.encounters.length > 2)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => setState(() => _expanded = !_expanded),
              child: Text(_expanded ? l10n.trophyShowLess : l10n.trophyShowMore),
            ),
          ),
      ],
    );
  }
}
