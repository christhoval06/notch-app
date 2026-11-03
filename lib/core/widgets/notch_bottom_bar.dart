import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/notch_bottom_bar_item_chip.dart';

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
    final scheme = Theme.of(context).colorScheme;
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
            children: List.generate(items.length, (index) {
              final isSelected = index == currentIndex;
              return Expanded(
                flex: (isSelected && showSelectedLabel) ? 2 : 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: NotchBottomBarItemChip(
                    item: items[index],
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
