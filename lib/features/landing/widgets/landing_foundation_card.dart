import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/tonal_panel.dart';

class LandingFoundationCard extends StatelessWidget {
  const LandingFoundationCard({
    super.key,
    required this.title,
    required this.body,
    required this.link,
    required this.icon,
    required this.accent,
    required this.onTap,
  });
  final String title;
  final String body;
  final String link;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => TonalPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: .13),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: accent),
        ),
        const SizedBox(height: 24),
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Text(body),
        const SizedBox(height: 24),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: accent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: Text(link)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 15),
            ],
          ),
        ),
      ],
    ),
  );
}
