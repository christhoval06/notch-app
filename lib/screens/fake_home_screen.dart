import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/fake_task.dart';

class FakeHomeScreen extends StatefulWidget {
  @override
  _FakeHomeScreenState createState() => _FakeHomeScreenState();
}

class _FakeHomeScreenState extends State<FakeHomeScreen> {
  final _tasksBox = Hive.box<FakeTask>('fake_tasks');

  // DIÁLOGO PARA AÑADIR NUEVA TAREA
  Future<void> _showAddTaskDialog() async {
    final titleController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[200],
          title: const Text(
            'Nueva Tarea',
            style: TextStyle(color: Colors.black),
          ),
          content: TextField(
            controller: titleController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Ej. Comprar leche'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Añadir', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  final newTask = FakeTask(
                    id: const Uuid().v4(),
                    title: titleController.text,
                  );
                  _tasksBox.add(newTask);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Título con texto negro y fondo blanco
        title: const Text(
          "Mis Tareas",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0, // Sombra sutil para separar
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      backgroundColor: Colors.grey[200], // Un gris muy claro para el fondo

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.blueAccent, // Color de acción estándar
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: ValueListenableBuilder(
        valueListenable: _tasksBox.listenable(),
        builder: (context, Box<FakeTask> box, _) {
          final tasks = box.values.toList();

          if (tasks.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_box_outline_blank,
                    size: 60,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Todo listo por hoy.\n¡Añade una nueva tarea!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 80,
            ), // Padding para el FAB
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Dismissible(
                key: Key(task.id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  final taskTitle =
                      task.title; // Guardamos el título antes de borrar
                  task.delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tarea "$taskTitle" eliminada')),
                  );
                },
                background: Container(
                  color: Colors.red.shade400, // Un rojo menos intenso
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
                child: Card(
                  elevation: 1.5, // Sombra ligera para cada tarjeta
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    leading: Checkbox(
                      value: task.isDone,
                      activeColor: Colors.blueAccent, // Color al marcar
                      onChanged: (value) {
                        task.isDone = value!;
                        task.save();
                      },
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        decoration: task.isDone
                            ? TextDecoration.lineThrough
                            : null,
                        decorationColor: Colors.black54,
                        decorationThickness: 1.5,
                        // Color del texto: Negro si no está hecha, gris si está hecha
                        color: task.isDone ? Colors.black45 : Colors.black87,
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
}
