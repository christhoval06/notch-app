import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTableCard extends StatelessWidget {
  const CalendarTableCard({
    super.key,
    required this.localeCode,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.eventLoader,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
  });

  final String localeCode;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final CalendarFormat calendarFormat;
  final List<Encounter> Function(DateTime day) eventLoader;
  final void Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final void Function(CalendarFormat format) onFormatChanged;
  final void Function(DateTime focusedDay) onPageChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TableCalendar<Encounter>(
        locale: localeCode,
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: focusedDay,
        calendarFormat: calendarFormat,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        calendarStyle: CalendarStyle(
          defaultTextStyle: TextStyle(color: scheme.onSurface),
          weekendTextStyle: TextStyle(color: scheme.onSurfaceVariant),
          todayDecoration: BoxDecoration(
            color: scheme.secondaryContainer,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: scheme.primary,
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: scheme.tertiary,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(color: scheme.onSurface, fontSize: 18),
          leftChevronIcon: Icon(Icons.chevron_left, color: scheme.onSurface),
          rightChevronIcon: Icon(Icons.chevron_right, color: scheme.onSurface),
        ),
        eventLoader: eventLoader,
        onDaySelected: onDaySelected,
        onFormatChanged: onFormatChanged,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
