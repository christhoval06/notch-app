import 'package:flutter/material.dart';

class StatsSectionTitle extends StatelessWidget {
  const StatsSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: scheme.onSurfaceVariant,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.1,
      ),
    );
  }
}
