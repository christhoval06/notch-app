import 'package:flutter/material.dart';
import 'package:notch_app/theme/app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData dark() {
    final ThemeData base = ThemeData.dark();
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: AppColors.seedBlue,
      brightness: Brightness.dark,
    ).copyWith(
      secondary: AppColors.accentPurple,
      tertiary: AppColors.success,
      error: AppColors.error,
      surface: AppColors.bgSecondary,
    );

    return base.copyWith(
      colorScheme: scheme,
      primaryColor: scheme.primary,
      scaffoldBackgroundColor: AppColors.bgPrimary,
      textTheme: base.textTheme
          .apply(
            fontFamily: 'Lato',
            bodyColor: scheme.onSurface,
            displayColor: scheme.onSurface,
          )
          .copyWith(
            headlineSmall: base.textTheme.headlineSmall?.copyWith(
              fontFamily: 'BebasNeue',
            ),
            headlineMedium: base.textTheme.headlineMedium?.copyWith(
              fontFamily: 'BebasNeue',
            ),
          ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: AppColors.bgPrimary,
        foregroundColor: scheme.onSurface,
        titleTextStyle: TextStyle(
          fontFamily: 'BebasNeue',
          fontSize: 22,
          color: scheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
