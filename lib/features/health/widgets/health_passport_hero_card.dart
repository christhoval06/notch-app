import 'package:flutter/material.dart';

class HealthPassportHeroCard extends StatelessWidget {
  const HealthPassportHeroCard({
    super.key,
    required this.subtitle,
    required this.primaryLabel,
    required this.onPrimaryTap,
    this.latestDateLabel,
    this.followUpLabel,
    this.resultChild,
    this.summaryChild,
  });

  final String subtitle;
  final String primaryLabel;
  final VoidCallback onPrimaryTap;
  final String? latestDateLabel;
  final String? followUpLabel;
  final Widget? resultChild;
  final Widget? summaryChild;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final narrow = MediaQuery.sizeOf(context).width < 380;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: scheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flex(
            direction: narrow ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: narrow ? 0 : 1,
                child: Text(
                  subtitle,
                  style: textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              SizedBox(width: narrow ? 0 : 12, height: narrow ? 14 : 0),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.health_and_safety_outlined,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          if (latestDateLabel != null ||
              followUpLabel != null ||
              resultChild != null) ...[
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                if (latestDateLabel != null) _MetaChip(label: latestDateLabel!),
                if (followUpLabel != null) _MetaChip(label: followUpLabel!),
                if (resultChild != null) resultChild!,
              ],
            ),
          ],
          if (summaryChild != null) ...[
            const SizedBox(height: 16),
            summaryChild!,
          ],
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onPrimaryTap,
            icon: const Icon(Icons.add_rounded),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            label: Text(primaryLabel, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: textTheme.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
      ),
    );
  }
}
