import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/services/achievement_engine.dart';
import 'package:notch_app/utils/achievement_localization.dart';
import 'package:notch_app/utils/gamification_engine.dart';
import '../models/health_log.dart';
import '../services/notification_service.dart';

class HealthPassportScreen extends StatefulWidget {
  @override
  _HealthPassportScreenState createState() => _HealthPassportScreenState();
}

class _HealthPassportScreenState extends State<HealthPassportScreen> {
  void _addNewLog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final testTypeController = TextEditingController();
    String result = l10n.healthResultNegative; // Valor por defecto
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.healthNewRecord,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tipo de Prueba
                  TextField(
                    controller: testTypeController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: l10n.healthTestTypeLabel,
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Selector de Resultado
                  Text(
                    l10n.healthResultLabel,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                        [
                          l10n.healthResultNegative,
                          l10n.healthResultPositive,
                          l10n.healthResultPending,
                        ].map((val) {
                          return ChoiceChip(
                            label: Text(val),
                            selected: result == val,
                            selectedColor: val == l10n.healthResultNegative
                                ? Colors.green
                                : (val == l10n.healthResultPositive
                                      ? Colors.redAccent
                                      : Colors.orange),
                            onSelected: (selected) {
                              setModalState(() => result = val);
                            },
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Botón Guardar
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: Text(l10n.healthSaveAndSchedule),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        if (testTypeController.text.isEmpty) return;

                        // 1. Guardar en Hive
                        final log = HealthLog(
                          date: selectedDate,
                          testType: testTypeController.text,
                          result: result,
                        );
                        Hive.box<HealthLog>('health_logs').add(log);

                        // 2. Programar Notificación
                        await NotificationService().scheduleCheckupReminder(
                          months: 6,
                        );

                        final unlocked = await AchievementEngine.processEvent(
                          event: AchievementEvent.healthLogSaved,
                          data: {
                            'allHealthLogs': Hive.box<HealthLog>(
                              'health_logs',
                            ).values.toList(),
                          },
                        );

                        if (unlocked.isNotEmpty && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                l10n.dataAchievementUnlocked(
                                  localizeAchievementName(
                                    l10n,
                                    unlocked.first.id,
                                    unlocked.first.name,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.healthSavedReminder),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeCode = Localizations.localeOf(context).toString();
    final box = Hive.box<HealthLog>('health_logs');

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addNewLog(context),
        backgroundColor: Colors.blueAccent,
        icon: const Icon(Icons.add),
        label: Text(l10n.healthRegisterTest),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<HealthLog> box, _) {
          final logs = box.values.toList();
          // Ordenar: más reciente primero
          logs.sort((a, b) => b.date.compareTo(a.date));

          if (logs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.medical_services_outlined,
                    size: 60,
                    color: Colors.grey[800],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.healthNoRecords,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    l10n.healthNoRecordsSubtitle,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return Card(
                color: Colors.grey[900],
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getColor(log.result).withOpacity(0.2),
                    child: Icon(
                      _getIcon(log.result),
                      color: _getColor(log.result),
                    ),
                  ),
                  title: Text(
                    log.testType,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('d MMMM y', localeCode).format(log.date),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _getColor(log.result).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _getColor(log.result)),
                    ),
                    child: Text(
                      log.result.toUpperCase(),
                      style: TextStyle(
                        color: _getColor(log.result),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getColor(String result) {
    if (result == AppLocalizations.of(context).healthResultNegative)
      return Colors.greenAccent;
    if (result == AppLocalizations.of(context).healthResultPositive)
      return Colors.redAccent;
    return Colors.orangeAccent;
  }

  IconData _getIcon(String result) {
    if (result == AppLocalizations.of(context).healthResultNegative)
      return Icons.check_circle_outline;
    if (result == AppLocalizations.of(context).healthResultPositive)
      return Icons.warning_amber_rounded;
    return Icons.hourglass_empty;
  }
}
