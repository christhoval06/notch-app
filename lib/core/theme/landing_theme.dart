import 'package:flutter/material.dart';

abstract final class LandingTheme {
  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      primary: Color(0xFFB6C4FF),
      onPrimary: Color(0xFF092976),
      primaryContainer: Color(0xFF8DA4F7),
      onPrimaryContainer: Color(0xFF1C3783),
      secondary: Color(0xFFDDB7FF),
      onSecondary: Color(0xFF490080),
      secondaryContainer: Color(0xFF6F00BE),
      tertiary: Color(0xFF4EDEA3),
      onTertiary: Color(0xFF003824),
      surface: Color(0xFF121316),
      onSurface: Color(0xFFE3E2E6),
      onSurfaceVariant: Color(0xFFC5C5D3),
      surfaceContainerLowest: Color(0xFF0D0E11),
      surfaceContainerLow: Color(0xFF1B1B1F),
      surfaceContainer: Color(0xFF1F1F23),
      surfaceContainerHigh: Color(0xFF292A2D),
      surfaceContainerHighest: Color(0xFF343538),
      outline: Color(0xFF8F909C),
      outlineVariant: Color(0xFF444651),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
    );
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surfaceContainerLowest,
      fontFamily: 'PlusJakartaSans',
    );
    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: TextStyle(
          color: scheme.onSurface,
          fontFamily: 'PlusJakartaSans',
          fontSize: 64,
          height: 1.12,
          fontWeight: FontWeight.w800,
          letterSpacing: -2.4,
        ),
        headlineLarge: TextStyle(
          color: scheme.onSurface,
          fontFamily: 'PlusJakartaSans',
          fontSize: 34,
          height: 1.2,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.1,
        ),
        headlineMedium: TextStyle(
          color: scheme.onSurface,
          fontFamily: 'PlusJakartaSans',
          fontSize: 28,
          height: 1.25,
          fontWeight: FontWeight.w700,
          letterSpacing: -.7,
        ),
        titleLarge: TextStyle(
          color: scheme.onSurface,
          fontFamily: 'PlusJakartaSans',
          fontSize: 20,
          height: 1.35,
          fontWeight: FontWeight.w700,
          letterSpacing: -.4,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.7,
          color: scheme.onSurfaceVariant,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          height: 1.65,
          color: scheme.onSurfaceVariant,
        ),
        labelSmall: TextStyle(
          color: scheme.onSurface,
          fontFamily: 'PlusJakartaSans',
          fontSize: 11,
          height: 1.4,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.onSurfaceVariant,
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant.withValues(alpha: .3),
      ),
    );
  }
}
