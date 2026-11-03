import 'package:flutter/material.dart';

class AddEntrySectionLabel extends StatelessWidget {
  const AddEntrySectionLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 16),
      ),
    );
  }
}
