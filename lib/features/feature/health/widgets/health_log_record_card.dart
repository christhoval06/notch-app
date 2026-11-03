import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/feature/health/services/health_log_result_style_service.dart';
import 'package:notch_app/features/feature/health/widgets/health_passport_result_chip.dart';

class HealthLogRecordCard extends StatelessWidget {
  const HealthLogRecordCard({
    super.key,
    required this.log,
    required this.isLatest,
  });

  final HealthLog log;
  final bool isLatest;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toString();
    final style = HealthLogResultStyleService.resolve(context, log.result);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isLatest ? style.outline : scheme.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RecordBadge(icon: style.icon, color: style.accent),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      log.testType,
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('d MMMM y', locale).format(log.date),
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              HealthPassportResultChip(result: log.result),
            ],
          ),
          if (log.notes?.trim().isNotEmpty ?? false) ...[
            const SizedBox(height: 12),
            Text(
              log.notes!.trim(),
              style: TextStyle(color: scheme.onSurfaceVariant, height: 1.4),
            ),
          ],
        ],
      ),
    );
  }
}

class _RecordBadge extends StatelessWidget {
  const _RecordBadge({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
