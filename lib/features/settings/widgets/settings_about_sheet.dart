import 'package:flutter/material.dart';
import 'package:notch_app/features/settings/widgets/settings_about_pillar.dart';

class SettingsAboutSheet extends StatelessWidget {
  const SettingsAboutSheet({
    super.key,
    required this.title,
    required this.description,
    required this.pillars,
  });

  final String title;
  final String description;
  final List<SettingsAboutPillarData> pillars;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        constraints: const BoxConstraints(maxHeight: 560),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: scheme.outlineVariant,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(color: scheme.onSurfaceVariant, height: 1.45),
              ),
              const SizedBox(height: 18),
              for (var i = 0; i < pillars.length; i++) ...[
                SettingsAboutPillar(
                  icon: pillars[i].icon,
                  title: pillars[i].title,
                  body: pillars[i].body,
                ),
                if (i < pillars.length - 1) const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsAboutPillarData {
  const SettingsAboutPillarData({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;
}
