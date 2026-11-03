import 'package:flutter/material.dart';
import 'package:notch_app/core/constants/landing_config.dart';
import 'package:notch_app/core/router/app_router.dart';
import 'package:notch_app/core/theme/landing_theme.dart';
import 'package:notch_app/features/landing/services/landing_link_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingApp extends StatefulWidget {
  const LandingApp({
    super.key,
    this.locale,
    this.links = const ExternalLandingLinkService(),
  });
  final Locale? locale;
  final LandingLinkService links;

  @override
  State<LandingApp> createState() => _LandingAppState();
}

class _LandingAppState extends State<LandingApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    _locale =
        widget.locale ??
        Locale(deviceLocale.languageCode == 'es' ? 'es' : 'en');
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: LandingConfig.brand,
    debugShowCheckedModeBanner: false,
    theme: LandingTheme.dark(),
    locale: _locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    routes: AppRouter.landing(
      links: widget.links,
      onToggleLocale: () => setState(() {
        _locale = Locale(_locale.languageCode == 'en' ? 'es' : 'en');
      }),
    ),
  );
}
