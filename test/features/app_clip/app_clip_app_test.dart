import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notch_app/core/app/app_clip_app.dart';
import 'package:notch_app/features/insights/widgets/calendar_table_card.dart';
import 'package:notch_app/features/insights/widgets/calendar_encounter_card.dart';

void main() {
  setUpAll(initializeDateFormatting);

  testWidgets('preview reuses real calendar and cards without opening Hive', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AppClipApp());
    await tester.pumpAndSettle();
    expect(find.byType(CalendarTableCard), findsOneWidget);
    expect(find.byType(CalendarEncounterCard), findsOneWidget);
    expect(find.byIcon(Icons.close), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('5').first);
    await tester.pumpAndSettle();
    expect(find.byType(CalendarEncounterCard), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('preview uses the main app Spanish translations', (tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.localesTestValue = const [Locale('es')];
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(const AppClipApp());
    await tester.pumpAndSettle();
    expect(find.text('Registro ficticio'), findsOneWidget);
    expect(find.text('Obtener Notch'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
