import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/data/models/monthly_progress.dart';

class PathLevelItem {
  const PathLevelItem({
    required this.rawLevelName,
    required this.xpRequired,
    required this.isUnlocked,
    required this.isCurrent,
  });

  final String rawLevelName;
  final int xpRequired;
  final bool isUnlocked;
  final bool isCurrent;
}

class PathViewModel {
  const PathViewModel({
    required this.currentLevelIndex,
    required this.totalProgress,
    required this.levels,
  });

  final int currentLevelIndex;
  final double totalProgress;
  final List<PathLevelItem> levels;
}

class PathViewModelService {
  const PathViewModelService._();

  static PathViewModel build(MonthlyProgress progress) {
    final levels = GamificationEngine.levels;
    final currentXp = progress.xp;
    var currentLevelIndex = 0;

    for (var index = levels.length - 1; index >= 0; index--) {
      if (currentXp >= (levels[index]['xp'] as int)) {
        currentLevelIndex = index;
        break;
      }
    }

    return PathViewModel(
      currentLevelIndex: currentLevelIndex,
      totalProgress: currentXp / (levels.last['xp'] as int),
      levels: List.generate(levels.length, (index) {
        final level = levels[index];
        return PathLevelItem(
          rawLevelName: level['name'] as String,
          xpRequired: level['xp'] as int,
          isUnlocked: currentXp >= (level['xp'] as int),
          isCurrent: index == currentLevelIndex,
        );
      }),
    );
  }
}
