import 'package:flutter/material.dart';

class NotchBottomBarItem {
  const NotchBottomBarItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class NotchBottomBar extends StatelessWidget {
  const NotchBottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.showSelectedLabel = true,
  }) : assert(items.length >= 2);

  final List<NotchBottomBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showSelectedLabel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Container(
          height: 82,
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(34),
            boxShadow: [
              BoxShadow(
                color: scheme.scrim.withValues(alpha: 0.08),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List<Widget>.generate(items.length, (int index) {
              final bool isSelected = index == currentIndex;
              final NotchBottomBarItem item = items[index];
              return Expanded(
                flex: (isSelected && showSelectedLabel) ? 2 : 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _BottomItem(
                    item: item,
                    isSelected: isSelected,
                    scheme: scheme,
                    showSelectedLabel: showSelectedLabel,
                    onTap: () => onTap(index),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  const _BottomItem({
    required this.item,
    required this.isSelected,
    required this.scheme,
    required this.showSelectedLabel,
    required this.onTap,
  });

  final NotchBottomBarItem item;
  final bool isSelected;
  final ColorScheme scheme;
  final bool showSelectedLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: isSelected ? 1 : 0),
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      builder: (BuildContext context, double bubble, Widget? child) {
        final double scale = 1 + (0.035 * bubble);

        return AnimatedSize(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          child: Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              height: 56,
              decoration: BoxDecoration(
                color: Color.lerp(
                  Colors.transparent,
                  scheme.primaryContainer.withValues(alpha: 0.38),
                  bubble,
                ),
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  if (bubble > 0.02)
                    BoxShadow(
                      color: scheme.primary.withValues(alpha: 0.12 * bubble),
                      blurRadius: 10 * bubble,
                      spreadRadius: 0.4 * bubble,
                    ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: onTap,
                  splashFactory: NoSplash.splashFactory,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.transparent;
                      }
                      if (states.contains(WidgetState.hovered)) {
                        return Colors.transparent;
                      }
                      if (states.contains(WidgetState.focused)) {
                        return Colors.transparent;
                      }
                      return null;
                    },
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSelected ? 8 : 4,
                      vertical: 4,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                            sizeFactor: animation,
                            axis: Axis.horizontal,
                            axisAlignment: -1,
                            child: child,
                          ),
                        );
                      },
                      child: (isSelected && showSelectedLabel)
                          ? Center(
                              child: Row(
                                key: ValueKey<String>('selected_${item.label}'),
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    item.icon,
                                    size: 28,
                                    color: scheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Text(
                                      item.label,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: scheme.onSurfaceVariant,
                                            height: 1.2,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              key: ValueKey<String>('unselected_${item.label}'),
                              child: Icon(
                                item.icon,
                                size: 28,
                                color: scheme.onSurface.withValues(alpha: 0.8),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
