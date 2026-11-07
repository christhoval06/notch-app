import 'package:flutter/material.dart';
import 'package:notch_app/data/models/fake_task.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class FakeTaskGroupedList extends StatelessWidget {
  final List<FakeTask> tasks;
  final void Function(FakeTask task) onToggle;
  final void Function(FakeTask task) onDelete;

  const FakeTaskGroupedList({
    super.key,
    required this.tasks,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final grouped = _groupByDate(tasks, l10n);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      itemCount: grouped.length,
      itemBuilder: (context, index) {
        final section = grouped[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
              child: Text(
                section.label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
            ...section.tasks.map((task) => _TaskTile(
                  task: task,
                  onToggle: onToggle,
                  onDelete: onDelete,
                )),
          ],
        );
      },
    );
  }
}

class _TaskSection {
  final String label;
  final List<FakeTask> tasks;
  _TaskSection({required this.label, required this.tasks});
}

List<_TaskSection> _groupByDate(List<FakeTask> tasks, AppLocalizations l10n) {
  final sorted = List<FakeTask>.from(tasks)
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  final map = <String, List<FakeTask>>{};
  for (final task in sorted) {
    final label = _dateLabel(task.createdAt, l10n);
    map.putIfAbsent(label, () => []).add(task);
  }
  return map.entries.map((e) => _TaskSection(label: e.key, tasks: e.value)).toList();
}

String _dateLabel(DateTime date, AppLocalizations l10n) {
  final now = DateTime.now();
  final day = DateTime(date.year, date.month, date.day);
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  if (day == today) return l10n.fakeToday;
  if (day == yesterday) return l10n.fakeYesterday;
  final d = date.day.toString().padLeft(2, '0');
  final m = date.month.toString().padLeft(2, '0');
  return '$d/$m';
}

class _TaskTile extends StatelessWidget {
  final FakeTask task;
  final void Function(FakeTask task) onToggle;
  final void Function(FakeTask task) onDelete;

  const _TaskTile({
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(task),
      background: Container(
        color: scheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete_outline, color: scheme.onError),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        leading: Checkbox(
          value: task.isDone,
          activeColor: Colors.blueAccent,
          onChanged: (_) => onToggle(task),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 16,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            decorationColor: scheme.onSurfaceVariant,
            decorationThickness: 1.5,
            color: task.isDone ? scheme.onSurfaceVariant : scheme.onSurface,
          ),
        ),
      ),
    );
  }
}
