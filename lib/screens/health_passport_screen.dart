import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/health_log.dart';
import '../services/notification_service.dart';

class HealthPassportScreen extends StatefulWidget {
  @override
  _HealthPassportScreenState createState() => _HealthPassportScreenState();
}

class _HealthPassportScreenState extends State<HealthPassportScreen> {
  void _addNewLog(BuildContext context) {
    final testTypeController = TextEditingController();
    String result = 'Negativo'; // Valor por defecto
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
                  const Text(
                    "Nuevo Registro Médico",
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
                    decoration: const InputDecoration(
                      labelText: "Tipo de Prueba (Ej. Panel Completo)",
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
                  const Text(
                    "Resultado:",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ['Negativo', 'Positivo', 'Pendiente'].map((val) {
                      return ChoiceChip(
                        label: Text(val),
                        selected: result == val,
                        selectedColor: val == 'Negativo'
                            ? Colors.green
                            : (val == 'Positivo'
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
                      label: const Text("Guardar & Programar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
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

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Guardado. Te avisaremos en 6 meses.",
                            ),
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
    final box = Hive.box<HealthLog>('health_logs');

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addNewLog(context),
        backgroundColor: Colors.blueAccent,
        icon: const Icon(Icons.add),
        label: const Text("Registrar Prueba"),
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
                  const Text(
                    "Sin registros médicos",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "La salud es sexy. ¡Hazte un chequeo!",
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
                    DateFormat('d MMMM y').format(log.date),
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
    if (result == 'Negativo') return Colors.greenAccent;
    if (result == 'Positivo') return Colors.redAccent;
    return Colors.orangeAccent;
  }

  IconData _getIcon(String result) {
    if (result == 'Negativo') return Icons.check_circle_outline;
    if (result == 'Positivo') return Icons.warning_amber_rounded;
    return Icons.hourglass_empty;
  }
}
