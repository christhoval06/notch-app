import 'package:flutter/material.dart';
import 'package:notch_app/features/app_clip/services/app_clip_sample_data.dart';
import 'package:notch_app/features/app_clip/widgets/app_clip_insights.dart';
import 'package:notch_app/features/app_clip/widgets/app_clip_install_button.dart';
import 'package:notch_app/features/insights/widgets/calendar_encounter_card.dart';
import 'package:notch_app/features/insights/widgets/calendar_table_card.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

class AppClipPage extends StatefulWidget {
  const AppClipPage({super.key});

  @override
  State<AppClipPage> createState() => _AppClipPageState();
}

class _AppClipPageState extends State<AppClipPage> {
  final _month = DateTime.now();
  late DateTime _focusedDay = _month;
  late DateTime _selectedDay = DateTime(_month.year, _month.month, 4);
  CalendarFormat _format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final sample = AppClipSampleData(
      month: _month,
      partnerLabel: l10n.appClipSampleEntry,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('NOTCH')),
      bottomNavigationBar: const AppClipInstallButton(),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  avatar: const Icon(Icons.auto_awesome, size: 18),
                  label: Text(l10n.appClipSampleBadge),
                ),
                const SizedBox(height: 12),
                Text(l10n.appClipDescription, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
          CalendarTableCard(
            localeCode: Localizations.localeOf(context).toString(),
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
            calendarFormat: _format,
            eventLoader: sample.forDay,
            onDaySelected: (selected, focused) => setState(() {
              _selectedDay = selected;
              _focusedDay = focused;
            }),
            onFormatChanged: (format) => setState(() => _format = format),
            onPageChanged: (focused) => setState(() => _focusedDay = focused),
          ),
          const SizedBox(height: 16),
          if (sample.forDay(_selectedDay).isEmpty)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(l10n.calendarNoActivity),
            ),
          for (final encounter in sample.forDay(_selectedDay))
            CalendarEncounterCard(encounter: encounter, readOnly: true),
          Padding(
            padding: const EdgeInsets.all(20),
            child: AppClipInsights(sample: sample),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              l10n.appClipPrivacy,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
