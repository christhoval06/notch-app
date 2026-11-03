import 'package:flutter/material.dart';
import 'package:notch_app/core/constants/landing_config.dart';
import 'package:notch_app/core/widgets/content_section.dart';
import 'package:notch_app/features/landing/services/landing_link_service.dart';
import 'package:notch_app/features/landing/state/landing_section.dart';
import 'package:notch_app/features/landing/widgets/landing_brand.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingFooter extends StatelessWidget {
  const LandingFooter({
    super.key,
    required this.onNavigate,
    required this.links,
  });
  final ValueChanged<LandingSection> onNavigate;
  final LandingLinkService links;

  Future<void> _support(BuildContext context) async {
    if (!await links.open(LandingConfig.supportUrl) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).landingLinkError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return ContentSection(
      color: scheme.surfaceContainerLow,
      verticalPadding: 48,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) => Wrap(
              spacing: 64,
              runSpacing: 32,
              children: [
                SizedBox(
                  width: constraints.maxWidth < 600
                      ? constraints.maxWidth
                      : 420,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LandingBrand(),
                      const SizedBox(height: 16),
                      Text(l.landingFooterBody),
                      const SizedBox(height: 16),
                      Text(
                        l.landingOffline,
                        style: TextStyle(color: scheme.tertiary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.landingFooterLinks,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => onNavigate(LandingSection.features),
                      child: Text(l.landingFeatures),
                    ),
                    TextButton(
                      onPressed: () => onNavigate(LandingSection.privacy),
                      child: Text(l.landingPrivacy),
                    ),
                    TextButton(
                      onPressed: () => onNavigate(LandingSection.pricing),
                      child: Text(l.landingPricing),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.landingSupport,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => _support(context),
                      child: Text(l.landingContact),
                    ),
                    TextButton(
                      onPressed: () => onNavigate(LandingSection.health),
                      child: Text(l.landingHealth),
                    ),
                    TextButton(
                      onPressed: () => onNavigate(LandingSection.faq),
                      child: Text(l.landingFaq),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Divider(),
          const SizedBox(height: 20),
          Wrap(
            spacing: 32,
            runSpacing: 12,
            children: [
              Text(
                l.landingCopyright,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                l.landingNoTrackers,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
