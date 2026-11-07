import 'package:flutter/material.dart';
import 'package:notch_app/features/gamification/widgets/share_preview_view.dart';

class SharePreviewScreen extends StatelessWidget {
  const SharePreviewScreen({
    super.key,
    required this.rankName,
    required this.currentXp,
    required this.progressToNextLevel,
    required this.totalEncountersThisMonth,
  });

  final String rankName;
  final int currentXp;
  final double progressToNextLevel;
  final int totalEncountersThisMonth;

  @override
  Widget build(BuildContext context) {
    return SharePreviewView(
      rankName: rankName,
      currentXp: currentXp,
      progressToNextLevel: progressToNextLevel,
      totalEncountersThisMonth: totalEncountersThisMonth,
    );
  }
}
