import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter/services.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/monetization/premium_access.dart';
import 'package:notch_app/monetization/premium_feature.dart';
import 'package:notch_app/screens/insights_screen.dart';
import 'package:notch_app/screens/path_screen.dart';
import 'package:notch_app/screens/settings_screen.dart';
import 'package:notch_app/widgets/notch_bottom_bar.dart';

import 'package:notch_app/views/calendar_view.dart';
import 'add_entry_screen.dart';
import 'black_book_screen.dart';
import 'health_passport_screen.dart';
import 'stats_screen.dart';
import 'trophy_room_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isChromeVisible = true;

  static final List<Widget> _widgetOptions = <Widget>[
    CalendarView(),
    BlackBookScreen(),
    TrophyRoomScreen(),
    HealthPassportScreen(),
    StatsScreen(),
  ];

  PremiumFeature? _featureForTab(int index) {
    if (index == 1) return PremiumFeature.blackBook;
    if (index == 2) return PremiumFeature.trophyRoom;
    if (index == 3) return PremiumFeature.healthPassport;
    if (index == 4) return PremiumFeature.stats;
    return null;
  }

  bool _supportsAutoHideChrome(int index) {
    return index == 1 || index == 2 || index == 4;
  }

  void _setChromeVisible(bool visible) {
    if (_isChromeVisible == visible) return;
    if (!mounted) return;
    setState(() => _isChromeVisible = visible);
  }

  void _onItemTapped(int index) async {
    final feature = _featureForTab(index);
    if (feature != null) {
      await PremiumAccess.guard(
        context: context,
        feature: feature,
        onAllowed: () {
          if (!mounted) return;
          setState(() {
            _selectedIndex = index;
            _isChromeVisible = true;
          });
        },
      );
      return;
    }

    if (!mounted) return;
    setState(() {
      _selectedIndex = index;
      _isChromeVisible = true;
    });
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (!_supportsAutoHideChrome(_selectedIndex)) return false;
    if (notification.depth != 0) return false;
    if (notification.metrics.axis != Axis.vertical) return false;
    if (notification is! UserScrollNotification) return false;

    if (notification.metrics.pixels <= 0 && !_isChromeVisible) {
      _setChromeVisible(true);
      return false;
    }

    if (notification.direction == ScrollDirection.reverse && _isChromeVisible) {
      _setChromeVisible(false);
    } else if (notification.direction == ScrollDirection.forward &&
        !_isChromeVisible) {
      _setChromeVisible(true);
    }
    return false;
  }

  Widget _buildTopBar(String title, double topInset) {
    final scheme = Theme.of(context).colorScheme;
    final background = Theme.of(context).scaffoldBackgroundColor;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: background,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Container(
        height: topInset + kToolbarHeight,
        padding: EdgeInsets.only(top: topInset),
        color: background,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.settings, color: scheme.onSurface),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SettingsScreen()),
                );
              },
            ),
            if (_selectedIndex == 2)
              IconButton(
                icon: Icon(Icons.map, color: scheme.onSurface),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PathScreen()),
                  );
                },
              ),
            if (_selectedIndex == 4)
              IconButton(
                icon: Icon(Icons.psychology, color: scheme.onSurface),
                onPressed: () async {
                  await PremiumAccess.guard(
                    context: context,
                    feature: PremiumFeature.insights,
                    onAllowed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => InsightsScreen()),
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(AppLocalizations l10n) {
    final List<NotchBottomBarItem> items = <NotchBottomBarItem>[
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
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      showSelectedLabel: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final appBarTitles = [
      'NOTCH',
      '${l10n.homeBlackBookTitle} 📒',
      '${l10n.homeTrophyRoomTitle} 🏆',
      '${l10n.homeHealthPassportTitle} 🏥',
      '${l10n.homeStatsTitle} 📊',
    ];

    final shouldAutoHide = _supportsAutoHideChrome(_selectedIndex);
    final chromeVisible = shouldAutoHide ? _isChromeVisible : true;

    Widget content = _widgetOptions.elementAt(_selectedIndex);
    if (shouldAutoHide) {
      content = NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: content,
      );
    }

    final topPadding = MediaQuery.paddingOf(context).top + kToolbarHeight;
    const double bottomPadding = 98.0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          AnimatedPadding(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.only(
              top: chromeVisible ? topPadding : 0,
              bottom: chromeVisible ? bottomPadding : 0,
            ),
            child: content,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (Widget child, Animation<double> animation) {
                final Animation<Offset> position = Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(animation);
                return ClipRect(
                  child: SlideTransition(position: position, child: child),
                );
              },
              child: chromeVisible
                  ? KeyedSubtree(
                      key: const ValueKey<String>('top_bar_visible'),
                      child: _buildTopBar(
                        appBarTitles[_selectedIndex],
                        MediaQuery.paddingOf(context).top,
                      ),
                    )
                  : const SizedBox(
                      key: ValueKey<String>('top_bar_hidden'),
                      height: 0,
                    ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (Widget child, Animation<double> animation) {
                final Animation<Offset> position = Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation);
                return ClipRect(
                  child: SlideTransition(position: position, child: child),
                );
              },
              child: chromeVisible
                  ? KeyedSubtree(
                      key: const ValueKey<String>('bottom_bar_visible'),
                      child: _buildBottomBar(l10n),
                    )
                  : const SizedBox(
                      key: ValueKey<String>('bottom_bar_hidden'),
                      height: 0,
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEntryScreen()),
                );
              },
            )
          : null,
    );
  }
}
