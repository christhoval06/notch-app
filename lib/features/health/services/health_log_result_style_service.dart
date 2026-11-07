import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';

enum HealthLogResultKind { negative, positive, pending }

class HealthLogResultStyle {
  const HealthLogResultStyle({
    required this.accent,
    required this.surface,
    required this.outline,
    required this.foreground,
    required this.icon,
  });

  final Color accent;
  final Color surface;
  final Color outline;
  final Color foreground;
  final IconData icon;
}

class HealthLogResultStyleService {
  const HealthLogResultStyleService._();

  static HealthLogResultStyle resolve(BuildContext context, String result) {
    final scheme = Theme.of(context).colorScheme;
    final accent = color(context, result);
    return HealthLogResultStyle(
      accent: accent,
      surface: accent.withValues(alpha: 0.12),
      outline: accent.withValues(alpha: 0.3),
      foreground: scheme.onSurface,
      icon: icon(result),
    );
  }

  static Color color(BuildContext context, String result) {
    final scheme = Theme.of(context).colorScheme;
    switch (kind(result)) {
      case HealthLogResultKind.negative:
        return scheme.success;
      case HealthLogResultKind.positive:
        return scheme.error;
      case HealthLogResultKind.pending:
        return scheme.warning;
    }
  }

  static IconData icon(String result) {
    switch (kind(result)) {
      case HealthLogResultKind.negative:
        return Icons.check_circle_outline;
      case HealthLogResultKind.positive:
        return Icons.warning_amber_rounded;
      case HealthLogResultKind.pending:
        return Icons.hourglass_empty;
    }
  }

  static HealthLogResultKind kind(String result) {
    final normalized = result.trim().toLowerCase();
    if (normalized == 'negative' || normalized == 'negativo') {
      return HealthLogResultKind.negative;
    }
    if (normalized == 'positive' || normalized == 'positivo') {
      return HealthLogResultKind.positive;
    }
    return HealthLogResultKind.pending;
  }
}
