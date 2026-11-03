import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:notch_app/features/feature/encounters/presentation/pages/add_entry_page.dart';
import 'package:notch_app/features/feature/home/services/home_tab_config.dart';
import 'package:notch_app/features/feature/home/widgets/home_bottom_bar.dart';
import 'package:notch_app/features/feature/home/widgets/home_chrome_scaffold.dart';
import 'package:notch_app/features/feature/home/widgets/home_top_bar.dart';
import 'package:notch_app/features/feature/insights/presentation/pages/insights_page.dart';
import 'package:notch_app/features/feature/insights/presentation/pages/stats_page.dart';
import 'package:notch_app/features/feature/path/presentation/pages/path_page.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  bool _isChromeVisible = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final shouldAutoHide = HomeTabConfig.supportsAutoHideChrome(_selectedIndex);
    final showHomeTopBar = HomeTabConfig.showHomeTopBar(_selectedIndex);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: HomeChromeScaffold(
        content: _contentFor(shouldAutoHide),
        chromeVisible: shouldAutoHide ? _isChromeVisible : true,
        topPadding: showHomeTopBar
            ? MediaQuery.paddingOf(context).top + kToolbarHeight
            : 0,
        bottomPadding: 98,
        topBar: showHomeTopBar
            ? _topBarFor(context, l10n)
            : const SizedBox.shrink(),
        bottomBar: HomeBottomBar(
          l10n: l10n,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _selectedIndex == 0 ? _buildFab(context) : null,
    );
  }

  Widget _contentFor(bool shouldAutoHide) {
    final currentTab = HomeTabConfig.tabs[_selectedIndex];
    if (!shouldAutoHide) return currentTab;
    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: currentTab,
    );
  }

  Widget _topBarFor(BuildContext context, AppLocalizations l10n) {
    return HomeTopBar(
      title: HomeTabConfig.titleFor(_selectedIndex, l10n),
      topInset: MediaQuery.paddingOf(context).top,
      showPathAction: false,
      showStatsAction: _selectedIndex == 2,
      showInsightsAction: false,
      onPathTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PathScreen()),
      ),
      onStatsTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const StatsScreen()),
      ),
      onInsightsTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => InsightsScreen()),
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 84),
      child: FloatingActionButton(
        backgroundColor: scheme.primary,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEntryScreen()),
        ),
        child: Icon(Icons.add, color: scheme.onPrimary),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (!mounted) return;
    setState(() {
      _selectedIndex = index;
      _isChromeVisible = true;
    });
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (!HomeTabConfig.supportsAutoHideChrome(_selectedIndex)) return false;
    if (notification.depth != 0 || notification.metrics.axis != Axis.vertical) {
      return false;
    }
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

  void _setChromeVisible(bool visible) {
    if (_isChromeVisible == visible || !mounted) return;
    setState(() => _isChromeVisible = visible);
  }
}
