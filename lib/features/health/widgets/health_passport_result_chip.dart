import 'package:flutter/material.dart';
import 'package:notch_app/features/health/services/health_log_result_style_service.dart';

class HealthPassportResultChip extends StatelessWidget {
  const HealthPassportResultChip({super.key, required this.result, this.label});

  final String result;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = HealthLogResultStyleService.resolve(context, result);
    final displayLabel = label ?? result;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: style.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: style.outline),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 220),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(style.icon, size: 14, color: style.accent),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                displayLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: style.foreground,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
