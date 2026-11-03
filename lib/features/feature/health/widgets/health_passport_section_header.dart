import 'package:flutter/material.dart';

class HealthPassportSectionHeader extends StatelessWidget {
  const HealthPassportSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final action = actionLabel != null && onActionTap != null
        ? TextButton(onPressed: onActionTap, child: Text(actionLabel!))
        : null;
    final hasAction = action != null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = hasAction && constraints.maxWidth < 360;
        if (!hasAction) {
          return _TitleBlock(title: title, subtitle: subtitle);
        }

        if (stacked) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleBlock(title: title, subtitle: subtitle),
              const SizedBox(height: 8),
              action,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _TitleBlock(title: title, subtitle: subtitle),
            ),
            const SizedBox(width: 12),
            action,
          ],
        );
      },
    );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({required this.title, required this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            color: scheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
