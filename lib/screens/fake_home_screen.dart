import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final titleController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: scheme.surface,
          title: Text(
            l10n.fakeNewTask,
            style: TextStyle(color: scheme.onSurface),
          ),
          content: TextField(
            controller: titleController,
            autofocus: true,
            style: TextStyle(color: scheme.onSurface),
            decoration: InputDecoration(hintText: l10n.fakeTaskHint),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                l10n.cancel,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(l10n.fakeAdd, style: TextStyle(color: scheme.primary)),
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
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        // Título con texto negro y fondo blanco
        title: Text(
          l10n.fakeMyTasks,
          style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.bold),
        ),
        backgroundColor: scheme.surface,
        elevation: 1.0, // Sombra sutil para separar
        iconTheme: IconThemeData(color: scheme.onSurfaceVariant),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: scheme.primary, // Color de acción estándar
        child: Icon(Icons.add, color: scheme.onPrimary),
      ),

      body: ValueListenableBuilder(
        valueListenable: _tasksBox.listenable(),
        builder: (context, Box<FakeTask> box, _) {
          final tasks = box.values.toList();

          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_box_outline_blank,
                    size: 60,
                    color: scheme.onSurfaceVariant,
                  ),
                  SizedBox(height: 10),
                  Text(
                    l10n.fakeAllDone,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 16,
                    ),
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
                    SnackBar(content: Text(l10n.fakeTaskDeleted(taskTitle))),
                  );
                },
                background: Container(
                  color: scheme.error,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.delete_outline,
                    color: scheme.onError,
                  ),
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
                      decorationColor: scheme.onSurfaceVariant,
                      decorationThickness: 1.5,
                      // Color del texto: Negro si no está hecha, gris si está hecha
                      color: task.isDone
                          ? scheme.onSurfaceVariant
                          : scheme.onSurface,
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
