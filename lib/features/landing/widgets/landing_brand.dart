import 'package:flutter/material.dart';
import 'package:notch_app/core/constants/landing_config.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingBrand extends StatelessWidget {
  const LandingBrand({super.key});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          LandingConfig.icon,
          width: 30,
          height: 30,
          excludeFromSemantics: true,
        ),
      ),
      const SizedBox(width: 10),
      Text(
        AppLocalizations.of(context).landingBrand,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 1,
        ),
      ),
    ],
  );
}
