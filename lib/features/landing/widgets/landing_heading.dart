import 'package:flutter/material.dart';

class LandingHeading extends StatelessWidget {
  const LandingHeading({
    super.key,
    required this.label,
    required this.title,
    this.body,
    this.centered = false,
    this.accent,
  });
  final String label;
  final String title;
  final String? body;
  final bool centered;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final align = centered ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: align,
          style: theme.textTheme.labelSmall?.copyWith(
            color: accent ?? theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Text(title, textAlign: align, style: theme.textTheme.headlineLarge),
        if (body != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              body!,
              textAlign: align,
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ],
    );
  }
}
