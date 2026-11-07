import 'package:flutter/material.dart';
import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class CalendarEncounterHeader extends StatelessWidget {
  const CalendarEncounterHeader({
    super.key,
    required this.encounter,
    this.readOnly = false,
  });

  final Encounter encounter;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            encounter.partnerName,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (!readOnly)
          InkWell(
            onTap: () => _showDeleteDialog(context, l10n, scheme),
            child: Icon(Icons.close, size: 16, color: scheme.onSurfaceVariant),
          ),
      ],
    );
  }

  Future<void> _showDeleteDialog(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme scheme,
  ) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: scheme.surface,
          title: Text(
            l10n.calendarConfirmDeleteTitle,
            style: TextStyle(color: scheme.onSurface),
          ),
          content: Text(l10n.calendarConfirmDeleteMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () {
                GamificationEngine.deleteEncounter(encounter);
                Navigator.pop(dialogContext);
              },
              child: Text(l10n.delete, style: TextStyle(color: scheme.error)),
            ),
          ],
        );
      },
    );
  }
}
