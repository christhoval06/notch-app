import 'package:flutter/material.dart';
import 'package:notch_app/features/landing/state/landing_section.dart';
import 'package:notch_app/features/landing/widgets/landing_brand.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingHeader extends StatelessWidget {
  const LandingHeader({
    super.key,
    required this.onNavigate,
    required this.onToggleLocale,
  });
  final ValueChanged<LandingSection> onNavigate;
  final VoidCallback onToggleLocale;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final labels = {
      LandingSection.features: l.landingFeatures,
      LandingSection.privacy: l.landingPrivacy,
      LandingSection.health: l.landingHealth,
      LandingSection.pricing: l.landingPricing,
      LandingSection.faq: l.landingFaq,
    };
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: .98),
        border: Border(
          bottom: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: .25),
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: LayoutBuilder(
                builder: (context, constraints) => Row(
                  children: [
                    const LandingBrand(),
                    const Spacer(),
                    if (constraints.maxWidth >= 1050)
                      for (final entry in labels.entries)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: TextButton(
                            onPressed: () => onNavigate(entry.key),
                            child: Text(entry.value),
                          ),
                        ),
                    if (constraints.maxWidth >= 1050) const Spacer(),
                    if (constraints.maxWidth >= 600)
                      FilledButton(
                        onPressed: () => onNavigate(LandingSection.pricing),
                        child: Text(l.landingGet),
                      ),
                    const SizedBox(width: 8),
                    IconButton(
                      tooltip: l.landingLanguageSwitch,
                      onPressed: onToggleLocale,
                      icon: const Icon(Icons.language, size: 20),
                    ),
                    if (constraints.maxWidth < 1050)
                      PopupMenuButton<LandingSection>(
                        tooltip: l.landingMenu,
                        icon: const Icon(Icons.menu),
                        onSelected: onNavigate,
                        itemBuilder: (_) => [
                          for (final e in labels.entries)
                            PopupMenuItem(value: e.key, child: Text(e.value)),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
