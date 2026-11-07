import 'package:flutter/material.dart';

class StatsReveal extends StatelessWidget {
  const StatsReveal({
    super.key,
    required this.child,
    required this.intervalStart,
  });

  final Widget child;
  final double intervalStart;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 650),
      tween: Tween(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        final progress = ((value - intervalStart) / 0.45).clamp(0.0, 1.0);
        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - progress)),
            child: child,
          ),
        );
      },
    );
  }
}
