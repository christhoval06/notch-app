import 'package:flutter/material.dart';
import 'package:notch_app/core/constants/app_constants.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/features/feature/onboarding/widgets/onboarding_pin_card.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class FinalOnboardingSlide extends StatelessWidget {
  const FinalOnboardingSlide({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.vpn_key, size: 80, color: scheme.warning),
          const SizedBox(height: 30),
          Text(
            l10n.onboardingPinsTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            l10n.onboardingPinsDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),
          OnboardingPinCard(
            title: l10n.onboardingRealPin,
            pin: DEFAULT_REAL_PIN,
            subtitle: l10n.onboardingRealPinSubtitle,
            color: scheme.primary,
          ),
          const SizedBox(height: 15),
          OnboardingPinCard(
            title: l10n.onboardingPanicPin,
            pin: DEFAULT_PANIC_PIN,
            subtitle: l10n.onboardingPanicPinSubtitle,
            color: scheme.warning,
          ),
        ],
      ),
    );
  }
}
