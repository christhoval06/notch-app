import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Existing brand accents already used across the app.
  static const Color seedBlue = Color(0xFF448AFF);
  static const Color accentPurple = Color(0xFFE040FB);
  static Color levelGradientBlue = Colors.blueAccent.shade700;
  // Color(0xFF448AFF);
  static Color levelGradientMagenta = Colors.purpleAccent.shade400;
  // Color(0xFFE040FB);

  // Existing dark surfaces currently hardcoded in multiple screens.
  static const Color bgPrimary = Color(0xFF121212);
  static const Color bgSecondary = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF19201B);

  // Semantic accents for status states.
  static const Color success = Color(0xFF4ADE80);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
}
