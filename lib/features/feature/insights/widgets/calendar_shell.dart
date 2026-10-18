import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/widgets/calendar_encounter_card.dart';
import 'package:notch_app/features/feature/insights/widgets/calendar_table_card.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarShell extends StatelessWidget {
  const CalendarShell({
    super.key,
    required this.header,
    required this.localeCode,
    required this.selectedDay,
    required this.selectedEncounters,
    required this.focusedDay,
    required this.calendarFormat,
    required this.eventLoader,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
  });

  final Widget header;
  final String localeCode;
  final DateTime selectedDay;
  final List<Encounter> selectedEncounters;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final List<Encounter> Function(DateTime day) eventLoader;
  final void Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final void Function(CalendarFormat format) onFormatChanged;
  final void Function(DateTime focusedDay) onPageChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(height: 20),
        header,
        const SizedBox(height: 14),
        CalendarTableCard(
          localeCode: localeCode,
          focusedDay: focusedDay,
          selectedDay: selectedDay,
          calendarFormat: calendarFormat,
          eventLoader: eventLoader,
          onDaySelected: onDaySelected,
          onFormatChanged: onFormatChanged,
          onPageChanged: onPageChanged,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                DateFormat('MMMM d, y', localeCode).format(selectedDay),
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: selectedEncounters.isEmpty
              ? Center(
                  child: Text(
                    l10n.calendarNoActivity,
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: selectedEncounters.length,
                  itemBuilder: (context, index) {
                    return CalendarEncounterCard(
                      encounter: selectedEncounters[index],
                    );
                  },
                ),
        ),
      ],
    );
  }
}
