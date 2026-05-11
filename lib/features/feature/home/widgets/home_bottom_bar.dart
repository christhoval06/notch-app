import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/notch_bottom_bar.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    required this.l10n,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final AppLocalizations l10n;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final items = <NotchBottomBarItem>[
      NotchBottomBarItem(icon: Icons.home_outlined, label: l10n.homeTab),
      NotchBottomBarItem(
        icon: Icons.menu_book_outlined,
        label: l10n.homePeopleTab,
      ),
      NotchBottomBarItem(
        icon: Icons.emoji_events_outlined,
        label: l10n.homeTrophiesTab,
      ),
      NotchBottomBarItem(
        icon: Icons.local_hospital_outlined,
        label: l10n.homeHealthTab,
      ),
      NotchBottomBarItem(
        icon: Icons.bar_chart_outlined,
        label: l10n.homeStatsTab,
      ),
    ];

    return NotchBottomBar(
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
      showSelectedLabel: true,
    );
  }
}
