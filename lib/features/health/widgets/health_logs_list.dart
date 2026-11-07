import 'package:flutter/material.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/health/widgets/health_logs_empty_state.dart';
import 'package:notch_app/features/health/widgets/health_logs_tile.dart';

class HealthLogsList extends StatelessWidget {
  const HealthLogsList({super.key, required this.logs});

  final List<HealthLog> logs;

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return const HealthLogsEmptyState();
    }
    return Column(
      children: List.generate(logs.length, (index) {
        return HealthLogsTile(log: logs[index], isLatest: index == 0);
      }),
    );
  }
}
