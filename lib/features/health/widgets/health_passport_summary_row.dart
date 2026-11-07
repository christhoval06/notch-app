import 'package:flutter/material.dart';

class HealthPassportSummaryRow extends StatelessWidget {
  const HealthPassportSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.accentColor,
    this.trailing,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? accentColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final accent = accentColor ?? scheme.primary;
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = trailing != null && constraints.maxWidth < 340;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null) ...[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(icon, color: accent, size: 18),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: textTheme.labelMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          value,
                          style: textTheme.titleMedium?.copyWith(
                            color: scheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!stacked && trailing != null) ...[
                    const SizedBox(width: 12),
                    Flexible(child: trailing!),
                  ],
                ],
              ),
              if (stacked) ...[const SizedBox(height: 12), trailing!],
            ],
          ),
        );
      },
    );
  }
}
