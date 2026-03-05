import 'package:notch_app/data/models/encounter.dart';

class AbstinenceService {
  static int currentAbstinenceDays(
    List<Encounter> encounters, {
    DateTime? now,
  }) {
    if (encounters.isEmpty) return 0;
    final anchor = now ?? DateTime.now();
    final sorted = List<Encounter>.from(encounters)
      ..sort((a, b) => b.date.compareTo(a.date));
    return anchor.difference(sorted.first.date).inDays;
  }

  static int longestAbstinenceDays(
    List<Encounter> encounters, {
    DateTime? now,
  }) {
    if (encounters.length <= 1) {
      return currentAbstinenceDays(encounters, now: now);
    }

    final sorted = List<Encounter>.from(encounters)
      ..sort((a, b) => a.date.compareTo(b.date));

    var longest = 0;
    for (var i = 1; i < sorted.length; i++) {
      final gapDays = sorted[i].date.difference(sorted[i - 1].date).inDays;
      if (gapDays > longest) {
        longest = gapDays;
      }
    }

    final currentGap = currentAbstinenceDays(encounters, now: now);
    return currentGap > longest ? currentGap : longest;
  }
}
