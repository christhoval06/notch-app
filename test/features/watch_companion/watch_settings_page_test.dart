import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notch_app/core/constants/watch_dashboard_cards.dart';
import 'package:notch_app/data/repositories/watch_layout_repository.dart';
import 'package:notch_app/features/watch_companion/presentation/pages/watch_settings_page.dart';
import 'package:notch_app/features/watch_companion/state/watch_layout_controller.dart';
import 'package:notch_app/l10n/app_localizations.dart';

void main() {
  testWidgets(
    'card toggles persist and all-off retains explanatory actions hint',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repository = WatchLayoutRepository(prefs);
      final controller = WatchLayoutController(repository);
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: WatchSettingsPage(controller: controller),
        ),
      );
      await tester.pumpAndSettle();
      final optional = find.byKey(const ValueKey(WatchDashboardCards.orgasms));
      await tester.ensureVisible(optional);
      await tester.tap(optional);
      await tester.pumpAndSettle();
      expect(repository.load(), ['abstinence', 'level', 'stats', 'orgasms']);
      for (final id in WatchDashboardCards.all) {
        await controller.setEnabled(id, false);
      }
      await tester.pumpAndSettle();
      expect(repository.load(), isEmpty);
      expect(
        find.text('No cards enabled. Entry and sync actions remain available.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
}
