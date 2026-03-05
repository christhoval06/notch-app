import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:notch_app/features/feature/gamification/presentation/pages/trophy_room_page.dart';
import 'package:notch_app/features/feature/encounters/presentation/pages/add_entry_page.dart';
import 'package:notch_app/features/feature/health/presentation/pages/health_passport_page.dart';
import 'package:notch_app/features/feature/insights/presentation/pages/insights_page.dart';
import 'package:notch_app/features/feature/insights/presentation/pages/stats_page.dart';
import 'package:notch_app/features/feature/insights/widgets/calendar_view.dart';
import 'package:notch_app/features/feature/journal/presentation/pages/black_book_page.dart';
import 'package:notch_app/features/feature/path/presentation/pages/path_page.dart';
import 'package:notch_app/features/feature/premium/models/premium_access.dart';
import 'package:notch_app/features/feature/premium/models/premium_feature.dart';
import 'package:notch_app/features/feature/settings/presentation/pages/settings_page.dart';
import 'package:notch_app/features/feature/home/widgets/home_bottom_bar.dart';
import 'package:notch_app/features/feature/home/widgets/home_chrome_scaffold.dart';
import 'package:notch_app/features/feature/home/widgets/home_top_bar.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isChromeVisible = true;

  static final _tabs = <Widget>[
    CalendarView(),
    BlackBookScreen(),
    TrophyRoomScreen(),
    HealthPassportScreen(),
    StatsScreen(),
  ];

  bool _supportsAutoHideChrome(int index) => index == 1 || index == 2 || index == 4;

  PremiumFeature? _featureForTab(int index) {
    if (index == 1) return PremiumFeature.blackBook;
    if (index == 2) return PremiumFeature.trophyRoom;
    if (index == 3) return PremiumFeature.healthPassport;
    if (index == 4) return PremiumFeature.stats;
    return null;
  }

  void _setChromeVisible(bool visible) {
    if (_isChromeVisible == visible || !mounted) return;
    setState(() => _isChromeVisible = visible);
  }

  Future<void> _onItemTapped(int index) async {
    final feature = _featureForTab(index);
    if (feature != null) {
      await PremiumAccess.guard(
        context: context,
        feature: feature,
        onAllowed: _selectTab(index),
      );
      return;
    }
    _selectTab(index)();
  }

  VoidCallback _selectTab(int index) => () {
    if (!mounted) return;
    setState(() {
      _selectedIndex = index;
      _isChromeVisible = true;
    });
  };

  bool _onScrollNotification(ScrollNotification notification) {
    if (!_supportsAutoHideChrome(_selectedIndex)) return false;
    if (notification.depth != 0 || notification.metrics.axis != Axis.vertical) return false;
    if (notification is! UserScrollNotification) return false;

    if (notification.metrics.pixels <= 0 && !_isChromeVisible) {
      _setChromeVisible(true);
      return false;
    }

    if (notification.direction == ScrollDirection.reverse && _isChromeVisible) {
      _setChromeVisible(false);
    } else if (notification.direction == ScrollDirection.forward && !_isChromeVisible) {
      _setChromeVisible(true);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final titles = [
      'NOTCH',
      '${l10n.homeBlackBookTitle} 📒',
      '${l10n.homeTrophyRoomTitle} 🏆',
      '${l10n.homeHealthPassportTitle} 🏥',
      '${l10n.homeStatsTitle} 📊',
    ];

    final shouldAutoHide = _supportsAutoHideChrome(_selectedIndex);
    final chromeVisible = shouldAutoHide ? _isChromeVisible : true;
    final content = shouldAutoHide
        ? NotificationListener<ScrollNotification>(
            onNotification: _onScrollNotification,
            child: _tabs[_selectedIndex],
          )
        : _tabs[_selectedIndex];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: HomeChromeScaffold(
        content: content,
        chromeVisible: chromeVisible,
        topPadding: MediaQuery.paddingOf(context).top + kToolbarHeight,
        bottomPadding: 98,
        topBar: HomeTopBar(
          title: titles[_selectedIndex],
          topInset: MediaQuery.paddingOf(context).top,
          showPathAction: _selectedIndex == 2,
          showInsightsAction: _selectedIndex == 4,
          onSettingsTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SettingsScreen()),
          ),
          onPathTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PathScreen()),
          ),
          onInsightsTap: () async => PremiumAccess.guard(
            context: context,
            feature: PremiumFeature.insights,
            onAllowed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => InsightsScreen()),
            ),
          ),
        ),
        bottomBar: HomeBottomBar(
          l10n: l10n,
          currentIndex: _selectedIndex,
          onTap: (index) => _onItemTapped(index),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _selectedIndex == 0
          ? Padding(
              // Keep FAB above the bottom bar even when the bar hides.
              padding: const EdgeInsets.only(bottom: 84),
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddEntryScreen()),
                ),
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
          : null,
    );
  }
}
