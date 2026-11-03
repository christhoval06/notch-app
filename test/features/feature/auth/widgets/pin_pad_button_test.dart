import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/features/feature/auth/widgets/pin_pad_button.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('pressed key shrinks while touch is held', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PinPadButton(label: '1', onPressed: () {}),
        ),
      ),
    );

    final gesture = await tester.startGesture(tester.getCenter(find.text('1')));
    await tester.pump(const Duration(milliseconds: 40));

    final animatedScale = tester.widget<AnimatedScale>(
      find.byType(AnimatedScale),
    );

    expect(animatedScale.scale, lessThan(1));

    await gesture.up();
  });

  testWidgets('tap triggers callback and haptic feedback', (tester) async {
    final calls = <MethodCall>[];
    final messenger = tester.binding.defaultBinaryMessenger;
    var tapped = false;

    messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      calls.add(call);
      return null;
    });

    addTearDown(
      () => messenger.setMockMethodCallHandler(SystemChannels.platform, null),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PinPadButton(label: '2', onPressed: () => tapped = true),
        ),
      ),
    );

    await tester.tap(find.text('2'));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
    expect(
      calls.any(
        (call) =>
            call.method == 'HapticFeedback.vibrate' &&
            call.arguments == 'HapticFeedbackType.selectionClick',
      ),
      isTrue,
    );
  });
}
