import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/content_section.dart';
import 'package:notch_app/features/landing/services/landing_link_service.dart';
import 'package:notch_app/features/landing/widgets/landing_download_button.dart';
import 'package:notch_app/features/landing/widgets/landing_hero_gallery.dart';
import 'package:notch_app/features/landing/widgets/landing_trust_strip.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingHero extends StatelessWidget {
  const LandingHero({super.key, required this.links, required this.onExplore});
  final LandingLinkService links;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final mobile = MediaQuery.sizeOf(context).width < 600;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -.3),
          radius: .9,
          colors: [
            Color.alphaBlend(
              scheme.primaryContainer.withValues(alpha: .08),
              scheme.surfaceContainerLowest,
            ),
            scheme.surfaceContainerLowest,
          ],
        ),
      ),
      child: ContentSection(
        verticalPadding: 56,
        color: scheme.surface.withValues(alpha: 0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: scheme.surfaceContainer,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                l.landingBadge,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  color: scheme.tertiary,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              l.landingHeroTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: mobile ? 38 : 64,
              ),
            ),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Text(
                l.landingHeroBody,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 28),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                LandingDownloadButton(links: links),
                OutlinedButton.icon(
                  onPressed: onExplore,
                  icon: const Icon(Icons.arrow_downward, size: 16),
                  label: Text(l.landingExplore),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(22),
                    foregroundColor: scheme.onSurface,
                    side: BorderSide(color: scheme.outlineVariant),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l.landingAndroid,
              style: theme.textTheme.bodySmall?.copyWith(color: scheme.outline),
            ),
            const SizedBox(height: 28),
            const LandingTrustStrip(),
            const SizedBox(height: 60),
            const LandingHeroGallery(),
          ],
        ),
      ),
    );
  }
}
