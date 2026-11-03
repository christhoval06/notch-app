import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/content_section.dart';
import 'package:notch_app/core/widgets/tonal_panel.dart';
import 'package:notch_app/features/landing/services/landing_link_service.dart';
import 'package:notch_app/features/landing/widgets/landing_download_button.dart';
import 'package:notch_app/features/landing/widgets/landing_heading.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingPricing extends StatelessWidget {
  const LandingPricing({super.key, required this.links});
  final LandingLinkService links;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return ContentSection(
      maxWidth: 920,
      child: Column(
        children: [
          LandingHeading(
            label: l.landingPricingLabel,
            title: l.landingPricingTitle,
            body: l.landingPricingBody,
            centered: true,
          ),
          const SizedBox(height: 36),
          TonalPanel(
            padding: 32,
            child: Column(
              children: [
                Text(
                  l.landingLicense,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(height: 32),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final copy = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 12,
                          children: [
                            Text(
                              l.landingPrice,
                              style: theme.textTheme.displayLarge?.copyWith(
                                fontSize: 48,
                              ),
                            ),
                            Text(l.landingPriceUnit),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l.landingPriceNote,
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 24),
                        Wrap(
                          spacing: 20,
                          runSpacing: 12,
                          children: [
                            for (final item in [
                              l.landingIncludedLogs,
                              l.landingIncludedSecurity,
                              l.landingIncludedHealth,
                              l.landingIncludedStats,
                              l.landingIncludedBook,
                              l.landingIncludedBackup,
                            ])
                              SizedBox(
                                width: 215,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.verified_outlined,
                                      size: 15,
                                      color: scheme.tertiary,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    );
                    final actions = Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LandingDownloadButton(links: links),
                        const SizedBox(height: 20),
                        Text(
                          l.landingAndroid,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    );
                    if (constraints.maxWidth < 700) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [copy, const SizedBox(height: 32), actions],
                      );
                    }
                    return Row(
                      children: [
                        Expanded(child: copy),
                        const SizedBox(width: 32),
                        actions,
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
