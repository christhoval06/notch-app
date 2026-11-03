import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/icon_label.dart';
import 'package:notch_app/core/constants/landing_config.dart';
import 'package:notch_app/core/widgets/content_section.dart';
import 'package:notch_app/features/landing/services/landing_link_service.dart';
import 'package:notch_app/features/landing/widgets/landing_download_button.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingFinalCta extends StatelessWidget {
  const LandingFinalCta({super.key, required this.links});
  final LandingLinkService links;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1,
          colors: [
            Color.alphaBlend(
              scheme.secondaryContainer.withValues(alpha: .12),
              scheme.surfaceContainerLowest,
            ),
            scheme.surfaceContainerLowest,
          ],
        ),
      ),
      child: ContentSection(
        maxWidth: 620,
        verticalPadding: 112,
        color: scheme.surface.withValues(alpha: 0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                LandingConfig.icon,
                width: 64,
                height: 64,
                excludeFromSemantics: true,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              l.landingCtaTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge?.copyWith(fontSize: 40),
            ),
            const SizedBox(height: 20),
            Text(
              l.landingCtaBody,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 28),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 16,
              children: [
                LandingDownloadButton(links: links),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(l.landingAndroid),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 12,
              children: [
                for (final text in [
                  l.landingNoAccounts,
                  l.landingNoSubscriptions,
                  l.landingNoTrackers,
                ])
                  IconLabel(
                    icon: Icons.check,
                    label: text,
                    color: scheme.tertiary,
                    style: theme.textTheme.bodySmall,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
