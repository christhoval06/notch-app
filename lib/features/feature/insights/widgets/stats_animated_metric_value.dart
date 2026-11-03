import 'package:flutter/material.dart';

class StatsAnimatedMetricValue extends StatelessWidget {
  const StatsAnimatedMetricValue({
    super.key,
    required this.value,
    required this.formatter,
  });

  final double value;
  final String Function(double value) formatter;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TweenAnimationBuilder<double>(
      tween: Tween(end: value),
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, _) {
        return Text(
          formatter(animatedValue),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: scheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        );
      },
    );
  }
}
