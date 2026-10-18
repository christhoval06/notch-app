import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsPartnerRecentEncounters extends StatefulWidget {
  const StatsPartnerRecentEncounters({
    super.key,
    required this.encounters,
  });

  final List<Encounter> encounters;

  @override
  State<StatsPartnerRecentEncounters> createState() =>
      _StatsPartnerRecentEncountersState();
}

class _StatsPartnerRecentEncountersState extends State<StatsPartnerRecentEncounters> {
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
        Text(l10n.statsPartnerRecentEncountersLabel, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
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
                Text(DateFormat.MMMd(locale).format(encounter.date), style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                const Spacer(),
                Text('${encounter.rating}', style: TextStyle(color: scheme.onSurface, fontSize: 20, fontWeight: FontWeight.w800)),
                const SizedBox(width: 10),
                Icon(encounter.protected ? Icons.security : Icons.gpp_bad_outlined, size: 16, color: protectionColor),
              ],
            ),
          );
        }),
        if (widget.encounters.length > 2)
          TextButton(
            onPressed: () => setState(() => _expanded = !_expanded),
            child: Text(_expanded ? l10n.trophyShowLess : l10n.trophyShowMore),
          ),
      ],
    );
  }
}
