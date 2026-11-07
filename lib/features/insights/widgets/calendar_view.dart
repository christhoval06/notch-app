import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/home/widgets/abstinence_counter_card.dart';
import 'package:notch_app/features/insights/widgets/calendar_shell.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Encounter>('encounters');
    final localeCode = Localizations.localeOf(context).toString();
    return ValueListenableBuilder<Box<Encounter>>(
      valueListenable: box.listenable(),
      builder: (context, encounterBox, _) {
        final selectedDay = _selectedDay ?? _focusedDay;
        return CalendarShell(
          header: const AbstinenceCounterCard(),
          localeCode: localeCode,
          selectedDay: selectedDay,
          selectedEncounters: _encountersForDay(selectedDay, encounterBox),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          eventLoader: (day) => _encountersForDay(day, encounterBox),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onFormatChanged: (format) {
            if (_calendarFormat == format) return;
            setState(() => _calendarFormat = format);
          },
          onPageChanged: (focusedDay) => _focusedDay = focusedDay,
        );
      },
    );
  }

  List<Encounter> _encountersForDay(DateTime day, Box<Encounter> box) {
    return box.values.where((item) => isSameDay(item.date, day)).toList();
  }
}
