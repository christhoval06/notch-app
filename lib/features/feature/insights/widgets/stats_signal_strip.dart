import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_premium_models.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_signal_card.dart';

class StatsSignalStrip extends StatelessWidget {
  const StatsSignalStrip({super.key, required this.signals});

  final List<StatsPremiumMetricData> signals;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 176,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: signals.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) =>
            StatsSignalCard(signal: signals[index]),
      ),
    );
  }
}
