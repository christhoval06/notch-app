import 'package:flutter/material.dart';
import 'package:notch_app/core/constants/landing_config.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingPhone extends StatelessWidget {
  const LandingPhone({
    super.key,
    required this.asset,
    this.width = 235,
    this.angle = 0,
  });
  final String asset;
  final double width;
  final double angle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(width * .09),
          border: Border.all(
            color: scheme.outlineVariant.withValues(alpha: .5),
          ),
          boxShadow: [
            BoxShadow(
              color: scheme.surfaceContainerLowest.withValues(alpha: .6),
              blurRadius: 28,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(width * .07),
          child: AspectRatio(
            aspectRatio: LandingConfig.screenshotAspectRatio,
            child: Image.asset(
              asset,
              fit: BoxFit.contain,
              semanticLabel: AppLocalizations.of(context).landingScreenshot,
              cacheWidth: (width * MediaQuery.devicePixelRatioOf(context))
                  .round(),
            ),
          ),
        ),
      ),
    );
  }
}
