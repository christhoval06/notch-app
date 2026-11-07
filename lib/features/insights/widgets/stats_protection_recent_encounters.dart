import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsProtectionRecentEncounters extends StatelessWidget {
  const StatsProtectionRecentEncounters({
    super.key,
    required this.encounters,
  });

  final List<Encounter> encounters;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.statsProtectionRecentEncountersLabel, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        ...encounters.map((encounter) => Container(
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
                  Text(encounter.partnerName, style: TextStyle(color: scheme.onSurfaceVariant)),
                ],
              ),
            )),
      ],
    );
  }
}
