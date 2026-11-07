import 'package:flutter/material.dart';
import 'package:notch_app/core/constants/app_routes.dart';
import 'package:notch_app/features/watch_companion/presentation/pages/watch_settings_page.dart';
import 'package:notch_app/features/landing/presentation/pages/landing_page.dart';
import 'package:notch_app/features/landing/services/landing_link_service.dart';

abstract final class AppRouter {
  static Map<String, WidgetBuilder> get mobile => {
    AppRoutes.watchSettings: (_) => const WatchSettingsPage(),
  };

  static Map<String, WidgetBuilder> landing({
    required VoidCallback onToggleLocale,
    required LandingLinkService links,
  }) => {
    AppRoutes.landing: (_) =>
        LandingPage(onToggleLocale: onToggleLocale, links: links),
  };
}
