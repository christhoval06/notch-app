import 'package:flutter/material.dart';
import 'package:notch_app/features/gamification/presentation/pages/trophy_room_page.dart';
import 'package:notch_app/features/insights/widgets/calendar_view.dart';
import 'package:notch_app/features/journal/presentation/pages/black_book_page.dart';
import 'package:notch_app/features/settings/presentation/pages/settings_page.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class HomeTabConfig {
  static final tabs = <Widget>[
    const CalendarView(),
    BlackBookScreen(),
    TrophyRoomScreen(),
    const SettingsScreen(),
  ];

  static bool supportsAutoHideChrome(int index) => index == 1 || index == 2;

  static bool showHomeTopBar(int index) => index != 3;

  static String titleFor(int index, AppLocalizations l10n) {
    switch (index) {
      case 1:
        return '${l10n.homeBlackBookTitle} 📒';
      case 2:
        return '${l10n.homeTrophyRoomTitle} 🏆';
      case 3:
        return 'Settings ⚙️';
      default:
        return 'NOTCH';
    }
  }
}
