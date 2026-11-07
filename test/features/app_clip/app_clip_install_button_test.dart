import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/core/constants/app_clip_config.dart';
import 'package:notch_app/features/app_clip/widgets/app_clip_install_button.dart';
import 'package:notch_app/l10n/app_localizations.dart';

void main() {
  const channel = MethodChannel(AppClipConfig.channel);

  Future<void> showButton(WidgetTester tester) => tester.pumpWidget(
    const MaterialApp(
      locale: Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(bottomNavigationBar: AppClipInstallButton()),
    ),
  );

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  testWidgets('Get Notch opens the published App Store listing', (
    tester,
  ) async {
    MethodCall? received;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (
      call,
    ) async {
      received = call;
      return null;
    });
    await showButton(tester);
    await tester.tap(find.text('Get Notch'));
    await tester.pumpAndSettle();

    expect(received?.method, 'openAppStore');
    expect(
      received?.arguments,
      'https://apps.apple.com/us/app/notch/id6759076734',
    );
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('failed redirect shows a recoverable error', (tester) async {
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (
      call,
    ) async {
      throw PlatformException(code: 'open_failed');
    });
    await showButton(tester);
    await tester.tap(find.text('Get Notch'));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
