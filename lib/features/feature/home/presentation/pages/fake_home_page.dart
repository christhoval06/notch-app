import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';
import 'package:notch_app/data/models/fake_task.dart';
import 'package:notch_app/features/feature/home/widgets/fake_add_task_dialog.dart';
import 'package:notch_app/features/feature/home/widgets/fake_task_grouped_list.dart';

enum _FakeTaskFilter { all, pending, completed }

class FakeHomeScreen extends StatefulWidget {
  @override
  _FakeHomeScreenState createState() => _FakeHomeScreenState();
}

class _FakeHomeScreenState extends State<FakeHomeScreen> {
  final _tasksBox = Hive.box<FakeTask>('fake_tasks');
  _FakeTaskFilter _filter = _FakeTaskFilter.all;

  List<FakeTask> _applyFilter(List<FakeTask> tasks) {
    switch (_filter) {
      case _FakeTaskFilter.pending:
        return tasks.where((task) => !task.isDone).toList();
      case _FakeTaskFilter.completed:
        return tasks.where((task) => task.isDone).toList();
      case _FakeTaskFilter.all:
        return tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.fakeMyTasks,
          style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.bold),
        ),
        backgroundColor: scheme.surface,
        elevation: 1.0,
        iconTheme: IconThemeData(color: scheme.onSurfaceVariant),
        actions: [
          PopupMenuButton<_FakeTaskFilter>(
            initialValue: _filter,
            onSelected: (value) => setState(() => _filter = value),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: _FakeTaskFilter.all,
                child: Text(l10n.fakeFilterAll),
              ),
              PopupMenuItem(
                value: _FakeTaskFilter.pending,
                child: Text(l10n.fakeFilterPending),
              ),
              PopupMenuItem(
                value: _FakeTaskFilter.completed,
                child: Text(l10n.fakeFilterCompleted),
              ),
            ],
            icon: Icon(Icons.filter_list_rounded, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      floatingActionButton: FloatingActionButton(
        onPressed: () => showFakeAddTaskDialog(
          context,
          onAdd: (title) {
            final newTask = FakeTask(id: const Uuid().v4(), title: title);
            _tasksBox.add(newTask);
          },
        ),
        backgroundColor: scheme.primary,
        child: Icon(Icons.add, color: scheme.onPrimary),
      ),

      body: ValueListenableBuilder(
        valueListenable: _tasksBox.listenable(),
        builder: (context, Box<FakeTask> box, _) {
          final tasks = _applyFilter(box.values.toList());

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
                  const SizedBox(height: 10),
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

          return FakeTaskGroupedList(
            tasks: tasks,
            onToggle: (task) {
              task.isDone = !task.isDone;
              task.save();
            },
            onDelete: (task) {
              final title = task.title;
              task.delete();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.fakeTaskDeleted(title))),
              );
            },
          );
        },
      ),
    );
  }
}
