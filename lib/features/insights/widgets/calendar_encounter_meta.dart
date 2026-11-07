import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class CalendarEncounterMeta extends StatelessWidget {
  const CalendarEncounterMeta({super.key, required this.encounter});

  final Encounter encounter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final protectionColor = encounter.protected ? scheme.tertiary : scheme.error;
    return Row(
      children: [
        Icon(Icons.bolt, size: 14, color: scheme.warning),
        const SizedBox(width: 4),
        Text(
          '${encounter.orgasmCount} ${l10n.orgasms}',
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 15),
        Icon(
          encounter.protected ? Icons.security : Icons.gpp_bad_outlined,
          size: 14,
          color: protectionColor,
        ),
        const SizedBox(width: 4),
        Text(
          encounter.protected ? l10n.safe : l10n.unsafe,
          style: TextStyle(color: protectionColor, fontSize: 12),
        ),
      ],
    );
  }
}
