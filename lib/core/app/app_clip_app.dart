import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notch_app/core/theme/app_theme.dart';
import 'package:notch_app/features/app_clip/presentation/pages/app_clip_page.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AppClipApp extends StatelessWidget {
  const AppClipApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'NOTCH',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.dark(),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: const AppClipPage(),
  );
}
