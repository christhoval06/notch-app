import 'package:flutter/material.dart';
import 'package:notch_app/core/configs/feature_flags.dart';

class FeatureGuard extends StatelessWidget {
  final String featureName;
  final Widget child;
  final Widget fallback;

  const FeatureGuard({
    super.key,
    required this.featureName,
    required this.child,
    this.fallback = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    if (FeatureFlags.isEnabled(featureName)) return child;
    return fallback;
  }
}
