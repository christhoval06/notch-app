import 'package:flutter/material.dart';

class HomeChromeScaffold extends StatelessWidget {
  const HomeChromeScaffold({
    required this.content,
    required this.chromeVisible,
    required this.topPadding,
    required this.bottomPadding,
    required this.topBar,
    required this.bottomBar,
    super.key,
  });

  final Widget content;
  final bool chromeVisible;
  final double topPadding;
  final double bottomPadding;
  final Widget topBar;
  final Widget bottomBar;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            transitionBuilder: _topTransition,
            child: chromeVisible
                ? KeyedSubtree(
                    key: const ValueKey<String>('top_bar_visible'),
                    child: topBar,
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
            transitionBuilder: _bottomTransition,
            child: chromeVisible
                ? KeyedSubtree(
                    key: const ValueKey<String>('bottom_bar_visible'),
                    child: bottomBar,
                  )
                : const SizedBox(
                    key: ValueKey<String>('bottom_bar_hidden'),
                    height: 0,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _topTransition(Widget child, Animation<double> animation) {
    final position = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(animation);
    return ClipRect(child: SlideTransition(position: position, child: child));
  }

  Widget _bottomTransition(Widget child, Animation<double> animation) {
    final position = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(animation);
    return ClipRect(child: SlideTransition(position: position, child: child));
  }
}
