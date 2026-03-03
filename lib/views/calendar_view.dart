import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/theme/color_scheme_semantics.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/utils/gamification_engine.dart';
import 'package:notch_app/widgets/abstinence_counter_card.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../models/encounter.dart';
import '../../utils/translations.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  List<Encounter> _getEncountersForDay(DateTime day, Box<Encounter> box) {
    return box.values.where((e) => isSameDay(e.date, day)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final box = Hive.box<Encounter>('encounters');
    final localeCode = Localizations.localeOf(context).toString();

    return ValueListenableBuilder<Box<Encounter>>(
      valueListenable: box.listenable(),
      builder: (context, box, _) {
        final selectedEncounters = _getEncountersForDay(_selectedDay!, box);
        return Column(
          children: [
            const SizedBox(height: 20),
            const AbstinenceCounterCard(),
            const SizedBox(height: 14),

            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 16.0,
            //     vertical: 8.0,
            //   ),
            //   child: ToggleButtons(
            //     isSelected: [
            //       _calendarFormat == CalendarFormat.month,
            //       _calendarFormat == CalendarFormat.week,
            //     ],
            //     onPressed: (index) {
            //       setState(() {
            //         _calendarFormat = index == 0
            //             ? CalendarFormat.month
            //             : CalendarFormat.week;
            //       });
            //     },
            //     borderRadius: BorderRadius.circular(8.0),
            //     selectedColor: Colors.white,
            //     color: Colors.grey,
            //     fillColor: Colors.blueAccent.withOpacity(0.3),
            //     borderColor: Colors.grey[700],
            //     selectedBorderColor: Colors.blueAccent,
            //     children: const [
            //       Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 16),
            //         child: Text("Mes"),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 16),
            //         child: Text("Semana"),
            //       ),
            //     ],
            //   ),
            // ),
            _buildCalendar(box, localeCode),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    DateFormat('MMMM d, y', localeCode).format(_selectedDay!),
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
                        AppLocalizations.of(context).calendarNoActivity,
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(
                        bottom: 80,
                      ), // Espacio para el FAB
                      itemCount: selectedEncounters.length,
                      itemBuilder: (context, index) =>
                          _buildEncounterCard(selectedEncounters[index]),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCalendar(Box<Encounter> box, String localeCode) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TableCalendar(
        locale: localeCode,
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

        // Estilos del calendario (Dark Mode)
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
          ), // Puntos de actividad
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(color: scheme.onSurface, fontSize: 18),
          leftChevronIcon: Icon(Icons.chevron_left, color: scheme.onSurface),
          rightChevronIcon: Icon(Icons.chevron_right, color: scheme.onSurface),
        ),

        // Cargar eventos (los puntos)
        eventLoader: (day) => _getEncountersForDay(day, box),

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }

  Widget _buildEncounterCard(Encounter item) {
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
          // 1. RATING Y EMOJI (Stacked)
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getRatingColor(item.rating).withValues(alpha: 0.2),
                  border: Border.all(
                    color: _getRatingColor(item.rating),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    "${item.rating}",
                    style: TextStyle(
                      color: _getRatingColor(item.rating),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              // Emoji flotante si existe
              if (item.moodEmoji != null)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: scheme.scrim,
                    ),
                    child: Text(
                      item.moodEmoji!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.partnerName,
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: scheme.surface,
                            title: Text(
                              l10n.calendarConfirmDeleteTitle,
                              style: TextStyle(color: scheme.onSurface),
                            ),
                            content: Text(l10n.calendarConfirmDeleteMessage),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: Text(l10n.cancel),
                              ),
                              TextButton(
                                onPressed: () {
                                  GamificationEngine.deleteEncounter(item);
                                  Navigator.pop(ctx);
                                },
                                child: Text(
                                  l10n.delete,
                                  style: TextStyle(color: scheme.error),
                                ),
                              ),
                            ],
                          ),
                        ),
                      },
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Icon(
                      Icons.bolt,
                      size: 14,
                      color: Theme.of(context).colorScheme.warning,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${item.orgasmCount} ${l10n.orgasms}",
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(width: 15), // Separación
                    // NUEVO: ICONO DE PROTECCIÓN
                    Icon(
                      item.protected ? Icons.security : Icons.gpp_bad_outlined,
                      size: 14,
                      color: item.protected
                          ? scheme.tertiary
                          : scheme.error,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.protected ? l10n.safe : l10n.unsafe,
                      style: TextStyle(
                        color: item.protected
                            ? scheme.tertiary
                            : scheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // 2. TAGS (Traducidos al vuelo)
                if (item.tags.isNotEmpty)
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: item.tags.map((tagKey) {
                      // Traducimos la key (ej: 'tag_morning') al idioma actual
                      final translatedTag = tagLabelFromL10n(l10n, tagKey);

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          translatedTag,
                          style: TextStyle(
                            color: scheme.onSurfaceVariant,
                            fontSize: 10,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Función para dar color según el rating (Gamificación visual)
  Color _getRatingColor(int rating) {
    final scheme = Theme.of(context).colorScheme;
    if (rating >= 9) return scheme.secondary; // Legendario
    if (rating >= 7) return scheme.tertiary; // Bueno
    if (rating >= 5) return scheme.primary; // Normal
    return scheme.error; // Malo
  }
}
