import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/core/theme/landing_theme.dart';

void main() {
  test('landing headlines use visible text colors on dark surfaces', () {
    final theme = LandingTheme.dark();
    for (final style in [
      theme.textTheme.displayLarge,
      theme.textTheme.headlineLarge,
      theme.textTheme.headlineMedium,
      theme.textTheme.titleLarge,
    ]) {
      expect(style?.color, theme.colorScheme.onSurface);
      expect(style?.fontFamily, 'PlusJakartaSans');
    }
  });
}
