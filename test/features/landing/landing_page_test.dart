import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/core/app/landing_app.dart';
import 'package:notch_app/features/landing/widgets/landing_phone.dart';
import 'package:notch_app/features/landing/services/landing_link_service.dart';

void main() {
  for (final width in [360.0, 768.0, 1440.0]) {
    testWidgets('landing renders without overflow at $width', (tester) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const LandingApp(locale: Locale('en')));
      await tester.pumpAndSettle();
      expect(find.text('Absolute Privacy.\nZero Compromises.'), findsOneWidget);
      final scroll = find.byType(SingleChildScrollView).first;
      for (var i = 0; i < 14; i++) {
        await tester.drag(scroll, const Offset(0, -650));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
      expect(find.text('Reclaim Your Intimate Privacy Today.'), findsOneWidget);
    });
  }

  testWidgets(
    'Spanish mobile layout supports larger text and menu navigation',
    (tester) async {
      tester.view.physicalSize = const Size(360, 900);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 1.5;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpWidget(const LandingApp(locale: Locale('es')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(find.byTooltip('Abrir navegación'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Preguntas').last);
      await tester.pumpAndSettle();
      expect(
        find.text('¿Cómo funciona el PIN señuelo?').hitTestable(),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('phone frames reserve image height while screenshots load', (
    tester,
  ) async {
    await tester.pumpWidget(const LandingApp(locale: Locale('en')));
    final phone = tester.getSize(find.byType(LandingPhone).first);
    expect(phone.height, greaterThan(phone.width * 2));
  });

  testWidgets('navigation reaches FAQ and accordion switches answers', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const LandingApp(locale: Locale('en')));
    await tester.tap(find.text('FAQ').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('How does the Decoy PIN work?'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('separate Decoy PIN').hitTestable(),
      findsOneWidget,
    );
    await tester.tap(find.text('What happens if I delete the app?'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('separate Decoy PIN').hitTestable(),
      findsNothing,
    );
    expect(
      find.textContaining('Export an encrypted backup').hitTestable(),
      findsOneWidget,
    );
  });

  testWidgets('language switch translates the landing', (tester) async {
    await tester.pumpWidget(const LandingApp(locale: Locale('en')));
    await tester.tap(find.byTooltip('Español'));
    await tester.pumpAndSettle();
    expect(find.text('Privacidad absoluta.\nSin compromisos.'), findsOneWidget);
  });

  testWidgets('all iOS download buttons open the NOTCH App Store listing', (
    tester,
  ) async {
    final links = RecordingLandingLinks();
    await tester.pumpWidget(
      LandingApp(locale: const Locale('en'), links: links),
    );
    final buttons = find.text('Download for iOS');
    expect(buttons, findsNWidgets(3));
    for (var i = 0; i < 3; i++) {
      await tester.ensureVisible(buttons.at(i));
      await tester.pumpAndSettle();
      await tester.tap(buttons.at(i));
      await tester.pumpAndSettle();
    }
    expect(
      links.opened,
      List.filled(3, 'https://apps.apple.com/us/app/notch/id6759076734'),
    );
  });
}

class RecordingLandingLinks implements LandingLinkService {
  final opened = <String>[];
  @override
  Future<bool> open(String url) async {
    opened.add(url);
    return true;
  }
}
