import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
    final box = Hive.box<Encounter>('encounters');

    return ValueListenableBuilder<Box<Encounter>>(
      valueListenable: box.listenable(),
      builder: (context, box, _) {
        final selectedEncounters = _getEncountersForDay(_selectedDay!, box);
        return Column(
          children: [
            const SizedBox(height: 20),

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
            _buildCalendar(box),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    DateFormat('MMMM d, y').format(_selectedDay!),
                    style: const TextStyle(
                      color: Colors.grey,
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
                        "Sin actividad este día.",
                        style: TextStyle(color: Colors.grey),
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

  Widget _buildCalendar(Box<Encounter> box) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

        // Estilos del calendario (Dark Mode)
        calendarStyle: const CalendarStyle(
          defaultTextStyle: TextStyle(color: Colors.white),
          weekendTextStyle: TextStyle(color: Colors.white70),
          todayDecoration: BoxDecoration(
            color: Colors.blueGrey,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: Colors.greenAccent,
            shape: BoxShape.circle,
          ), // Puntos de actividad
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[850]!),
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
                  color: _getRatingColor(item.rating).withOpacity(0.2),
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => item.delete(),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Icon(Icons.bolt, size: 14, color: Colors.orange[300]),
                    const SizedBox(width: 4),
                    Text(
                      "${item.orgasmCount} ${AppStrings.get('orgasms', lang: currentLang)}",
                      style: TextStyle(color: Colors.grey[400], fontSize: 13),
                    ),

                    const SizedBox(width: 15), // Separación
                    // NUEVO: ICONO DE PROTECCIÓN
                    Icon(
                      item.protected ? Icons.security : Icons.gpp_bad_outlined,
                      size: 14,
                      color: item.protected
                          ? Colors.greenAccent
                          : Colors.redAccent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.protected
                          ? "Safe"
                          : "Unsafe", // O usar traducciones si prefieres
                      style: TextStyle(
                        color: item.protected
                            ? Colors.greenAccent
                            : Colors.redAccent,
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
                      final translatedTag = AppStrings.get(
                        tagKey,
                        lang: currentLang,
                      );

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          translatedTag,
                          style: TextStyle(
                            color: Colors.grey[300],
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
    if (rating >= 9) return Colors.purpleAccent; // Legendario
    if (rating >= 7) return Colors.greenAccent; // Bueno
    if (rating >= 5) return Colors.blueAccent; // Normal
    return Colors.redAccent; // Malo
  }
}
