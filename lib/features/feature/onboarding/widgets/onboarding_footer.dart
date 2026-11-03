import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    super.key,
    required this.currentPage,
    required this.isLastPage,
    required this.onNext,
    required this.onFinish,
  });

  final double currentPage;
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isLastPage)
            DotsIndicator(
              dotsCount: 3,
              position: currentPage,
              decorator: DotsDecorator(
                color: scheme.outlineVariant,
                activeColor: scheme.primary,
                size: const Size.square(9),
                activeSize: const Size(18, 9),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          isLastPage
              ? ElevatedButton(
                  onPressed: onFinish,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: scheme.primary,
                  ),
                  child: Text(
                    l10n.onboardingGoToApp,
                    style: TextStyle(color: scheme.onPrimary),
                  ),
                )
              : ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: scheme.primary,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Icon(Icons.arrow_forward_ios, color: scheme.onPrimary),
                ),
        ],
      ),
    );
  }
}
