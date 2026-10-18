import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_premium_models.dart';
import 'package:notch_app/features/feature/insights/services/stats_premium_signal_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_editorial_models.dart';

class StatsPremiumIntelligenceService {
  const StatsPremiumIntelligenceService._();

  static StatsPremiumIntelligence build({
    required List<Encounter> current,
    required List<Encounter> previous,
    required StatsProtectionSummary protectionSummary,
    required StatsRhythmSummary rhythmSummary,
  }) {
    final consistency = StatsPremiumSignalService.consistency(
      current,
      previous,
    );
    final quality = StatsPremiumSignalService.quality(current, previous);
    final partnerMode = StatsPremiumSignalService.partnerMode(
      current,
      previous,
    );
    final protection = StatsPremiumSignalService.protection(
      protectionSummary,
      previous,
    );
    final rhythm = StatsPremiumSignalService.rhythm(rhythmSummary, current);
    final stories = [quality, protection, partnerMode, consistency, rhythm]
      ..sort((a, b) => b.score.compareTo(a.score));
    return StatsPremiumIntelligence(
      hero: _hero(stories),
      signals: [consistency, quality, partnerMode],
      stories: stories.take(3).toList(),
    );
  }

  static StatsPremiumMetricData _hero(List<StatsPremiumMetricData> stories) {
    final priority = {
      'quality': 5,
      'protection': 4,
      'partner_mode': 3,
      'consistency': 2,
      'rhythm': 1,
    };
    final sorted = [...stories]
      ..sort((a, b) {
        final scoreOrder = b.score.compareTo(a.score);
        if (scoreOrder != 0) return scoreOrder;
        return (priority[b.id] ?? 0).compareTo(priority[a.id] ?? 0);
      });
    return sorted.first;
  }
}
