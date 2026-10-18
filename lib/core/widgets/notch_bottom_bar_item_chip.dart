import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/notch_bottom_bar.dart';

class NotchBottomBarItemChip extends StatelessWidget {
  const NotchBottomBarItemChip({
    super.key,
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
      builder: (context, bubble, child) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          child: Transform.scale(
            scale: 1 + (0.035 * bubble),
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
                  overlayColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.pressed) ||
                        states.contains(WidgetState.hovered) ||
                        states.contains(WidgetState.focused)) {
                      return Colors.transparent;
                    }
                    return null;
                  }),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSelected ? 8 : 4,
                      vertical: 4,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                            sizeFactor: animation,
                            axis: Axis.horizontal,
                            alignment: Alignment.centerLeft,
                            child: child,
                          ),
                        );
                      },
                      child: isSelected && showSelectedLabel
                          ? _SelectedBottomBarItem(item: item, scheme: scheme)
                          : Center(
                              key: ValueKey('unselected_${item.label}'),
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

class _SelectedBottomBarItem extends StatelessWidget {
  const _SelectedBottomBarItem({required this.item, required this.scheme});

  final NotchBottomBarItem item;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        key: ValueKey('selected_${item.label}'),
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(item.icon, size: 28, color: scheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                    height: 1.2,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
