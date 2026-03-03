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
      surface: AppColors.bgSecondary,
    );

    return base.copyWith(
      colorScheme: scheme,
      primaryColor: scheme.primary,
      scaffoldBackgroundColor: AppColors.bgPrimary,
      textTheme: base.textTheme
          .apply(
            fontFamily: 'Lato',
            bodyColor: Colors.white,
            displayColor: Colors.white,
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
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontFamily: 'BebasNeue',
          fontSize: 22,
          color: Colors.white,
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
