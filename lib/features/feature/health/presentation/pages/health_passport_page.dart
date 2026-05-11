import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/core/utils/achievement_localization.dart';
import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/feature/health/services/notification_service.dart';

class HealthPassportScreen extends StatefulWidget {
  @override
  _HealthPassportScreenState createState() => _HealthPassportScreenState();
}

class _HealthPassportScreenState extends State<HealthPassportScreen> {
  void _addNewLog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final testTypeController = TextEditingController();
    String result = l10n.healthResultNegative; // Valor por defecto
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: scheme.surface,
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
                      color: scheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tipo de Prueba
                  TextField(
                    controller: testTypeController,
                    style: TextStyle(color: scheme.onSurface),
                    decoration: InputDecoration(
                      labelText: l10n.healthTestTypeLabel,
                      labelStyle: TextStyle(color: scheme.onSurfaceVariant),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: scheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: scheme.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Selector de Resultado
                  Text(
                    l10n.healthResultLabel,
                    style: TextStyle(color: scheme.onSurfaceVariant),
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
                                ? scheme.success
                                : (val == l10n.healthResultPositive
                                      ? scheme.error
                                      : scheme.warning),
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
                        backgroundColor: scheme.primary,
                        foregroundColor: scheme.onPrimary,
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
                            backgroundColor: scheme.primary,
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
    final theme = Theme.of(context);
    final localeCode = Localizations.localeOf(context).toString();
    final box = Hive.box<HealthLog>('health_logs');

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.homeHealthPassportTitle),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addNewLog(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
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
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.healthNoRecords,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    l10n.healthNoRecordsSubtitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
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
                color: Theme.of(context).colorScheme.surface,
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
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('d MMMM y', localeCode).format(log.date),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
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
      return Theme.of(context).colorScheme.success;
    if (result == AppLocalizations.of(context).healthResultPositive)
      return Theme.of(context).colorScheme.error;
    return Theme.of(context).colorScheme.warning;
  }

  IconData _getIcon(String result) {
    if (result == AppLocalizations.of(context).healthResultNegative)
      return Icons.check_circle_outline;
    if (result == AppLocalizations.of(context).healthResultPositive)
      return Icons.warning_amber_rounded;
    return Icons.hourglass_empty;
  }
}
