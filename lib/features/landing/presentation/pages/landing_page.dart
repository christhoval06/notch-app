import 'package:flutter/material.dart';
import 'package:notch_app/features/landing/services/landing_content_service.dart';
import 'package:notch_app/features/landing/services/landing_link_service.dart';
import 'package:notch_app/features/landing/state/landing_section.dart';
import 'package:notch_app/features/landing/widgets/landing_architecture.dart';
import 'package:notch_app/features/landing/widgets/landing_faq.dart';
import 'package:notch_app/features/landing/widgets/landing_feature_section.dart';
import 'package:notch_app/features/landing/widgets/landing_final_cta.dart';
import 'package:notch_app/features/landing/widgets/landing_footer.dart';
import 'package:notch_app/features/landing/widgets/landing_foundations.dart';
import 'package:notch_app/features/landing/widgets/landing_header.dart';
import 'package:notch_app/features/landing/widgets/landing_hero.dart';
import 'package:notch_app/features/landing/widgets/landing_pricing.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    super.key,
    required this.onToggleLocale,
    required this.links,
  });
  final VoidCallback onToggleLocale;
  final LandingLinkService links;
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _sections = {
    for (final section in LandingSection.values) section: GlobalKey(),
  };

  void _navigate(LandingSection section) {
    final target = _sections[section]?.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(
        target,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 550),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final features = LandingContentService.features(
      AppLocalizations.of(context),
    );
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            LandingHeader(
              onNavigate: _navigate,
              onToggleLocale: widget.onToggleLocale,
            ),
            Expanded(
              child: SelectionArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LandingHero(
                        links: widget.links,
                        onExplore: () => _navigate(LandingSection.features),
                      ),
                      LandingFoundations(onNavigate: _navigate),
                      for (var i = 0; i < features.length; i++)
                        LandingFeatureSection(
                          key: i == 0
                              ? _sections[LandingSection.features]
                              : i == 2
                              ? _sections[LandingSection.health]
                              : null,
                          feature: features[i],
                          index: i,
                        ),
                      LandingArchitecture(
                        key: _sections[LandingSection.privacy],
                      ),
                      LandingPricing(
                        key: _sections[LandingSection.pricing],
                        links: widget.links,
                      ),
                      LandingFaq(key: _sections[LandingSection.faq]),
                      LandingFinalCta(links: widget.links),
                      LandingFooter(onNavigate: _navigate, links: widget.links),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
