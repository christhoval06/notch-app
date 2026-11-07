import 'package:flutter/material.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/health/widgets/health_log_record_card.dart';

class HealthLogsTile extends StatelessWidget {
  const HealthLogsTile({super.key, required this.log, this.isLatest = false});

  final HealthLog log;
  final bool isLatest;

  @override
  Widget build(BuildContext context) {
    return HealthLogRecordCard(log: log, isLatest: isLatest);
  }
}
