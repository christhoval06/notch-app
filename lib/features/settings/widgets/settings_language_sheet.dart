import 'package:flutter/material.dart';

class SettingsLanguageSheet extends StatelessWidget {
  const SettingsLanguageSheet({super.key, required this.selectedCode});

  final String selectedCode;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Español', style: TextStyle(color: scheme.onSurface)),
            trailing: selectedCode == 'es'
                ? Icon(Icons.check, color: scheme.primary)
                : null,
            onTap: () => Navigator.pop(context, 'es'),
          ),
          ListTile(
            title: Text('English', style: TextStyle(color: scheme.onSurface)),
            trailing: selectedCode == 'en'
                ? Icon(Icons.check, color: scheme.primary)
                : null,
            onTap: () => Navigator.pop(context, 'en'),
          ),
        ],
      ),
    );
  }
}
