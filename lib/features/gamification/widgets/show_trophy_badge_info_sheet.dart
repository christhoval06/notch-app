import 'package:flutter/material.dart';
import 'package:notch_app/features/gamification/widgets/trophy_badge_info_sheet.dart';

Future<void> showTrophyBadgeInfoSheet(
  BuildContext context,
  String id,
  String name,
  String description,
  String icon,
  bool isUnlocked,
  bool isSeasonal,
  List<String> seasonMonthIds,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => TrophyBadgeInfoSheet(
      id: id,
      name: name,
      description: description,
      icon: icon,
      isUnlocked: isUnlocked,
      isSeasonal: isSeasonal,
      seasonMonthIds: seasonMonthIds,
    ),
  );
}
