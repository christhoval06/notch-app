import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class OnboardingSlideContent {
  const OnboardingSlideContent({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class OnboardingSlideContentService {
  const OnboardingSlideContentService._();

  static List<OnboardingSlideContent> build(AppLocalizations l10n) {
    return [
      OnboardingSlideContent(
        icon: Icons.shield_sharp,
        title: l10n.onboardingSlide1Title,
        description: l10n.onboardingSlide1Description,
      ),
      OnboardingSlideContent(
        icon: Icons.insights,
        title: l10n.onboardingSlide2Title,
        description: l10n.onboardingSlide2Description,
      ),
      OnboardingSlideContent(
        icon: Icons.trending_up,
        title: l10n.onboardingSlide3Title,
        description: l10n.onboardingSlide3Description,
      ),
    ];
  }
}
