import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/content_section.dart';
import 'package:notch_app/features/landing/state/landing_section.dart';
import 'package:notch_app/features/landing/widgets/landing_foundation_card.dart';
import 'package:notch_app/features/landing/widgets/landing_heading.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingFoundations extends StatelessWidget {
  const LandingFoundations({super.key, required this.onNavigate});
  final ValueChanged<LandingSection> onNavigate;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return ContentSection(
      color: scheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LandingHeading(
            label: l.landingFoundationsLabel,
            title: l.landingFoundationsTitle,
            body: l.landingFoundationsBody,
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final cards = [
                LandingFoundationCard(
                  title: l.landingSecurityTitle,
                  body: l.landingSecurityBody,
                  link: l.landingSecurityLink,
                  icon: Icons.shield_outlined,
                  accent: scheme.secondary,
                  onTap: () => onNavigate(LandingSection.privacy),
                ),
                LandingFoundationCard(
                  title: l.landingInsightsTitle,
                  body: l.landingInsightsBody,
                  link: l.landingInsightsLink,
                  icon: Icons.insights,
                  accent: scheme.primary,
                  onTap: () => onNavigate(LandingSection.features),
                ),
                LandingFoundationCard(
                  title: l.landingHealthTitle,
                  body: l.landingHealthBody,
                  link: l.landingHealthLink,
                  icon: Icons.health_and_safety_outlined,
                  accent: scheme.tertiary,
                  onTap: () => onNavigate(LandingSection.health),
                ),
              ];
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  for (final card in cards)
                    SizedBox(
                      width: constraints.maxWidth >= 900
                          ? (constraints.maxWidth - 40) / 3
                          : constraints.maxWidth,
                      child: card,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
