import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/widgets/calendar_encounter_header.dart';
import 'package:notch_app/features/insights/widgets/calendar_encounter_meta.dart';
import 'package:notch_app/features/insights/widgets/calendar_rating_badge.dart';
import 'package:notch_app/features/insights/widgets/calendar_tag_chip.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class CalendarEncounterCard extends StatelessWidget {
  const CalendarEncounterCard({
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarRatingBadge(encounter: encounter),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CalendarEncounterHeader(
                  encounter: encounter,
                  readOnly: readOnly,
                ),
                const SizedBox(height: 4),
                CalendarEncounterMeta(encounter: encounter),
                if (encounter.tags.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: encounter.tags.map((tagKey) {
                      return CalendarTagChip(label: _tagLabel(l10n, tagKey));
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _tagLabel(AppLocalizations l10n, String tagKey) {
    switch (tagKey) {
      case 'tag_morning':
        return l10n.tagMorning;
      case 'tag_quickie':
        return l10n.tagQuickie;
      case 'tag_oral':
        return l10n.tagOral;
      case 'tag_anal':
        return l10n.tagAnal;
      case 'tag_toys':
        return l10n.tagToys;
      case 'tag_date':
        return l10n.tagDate;
      case 'tag_travel':
        return l10n.tagTravel;
      case 'tag_kinky':
        return l10n.tagKinky;
      case 'tag_outdoor':
        return l10n.tagOutdoor;
      case 'tag_anniversary':
        return l10n.tagAnniversary;
      case 'tag_ons':
        return l10n.tagOns;
      case 'tag_fwb':
        return l10n.tagFwb;
      case 'tag_reconciliation':
        return l10n.tagReconciliation;
      case 'tag_celebration':
        return l10n.tagCelebration;
      case 'tag_vanilla':
        return l10n.tagVanilla;
      case 'tag_domsub':
        return l10n.tagDomsub;
      case 'tag_massage':
        return l10n.tagMassage;
      case 'tag_car':
        return l10n.tagCar;
      case 'tag_hotel':
        return l10n.tagHotel;
      case 'tag_shower':
        return l10n.tagShower;
      default:
        return tagKey;
    }
  }
}
