import 'package:flutter/material.dart';
import 'package:notch_app/features/path/services/path_view_model_service.dart';
import 'package:notch_app/features/path/widgets/path_node.dart';

class PathNodeRow extends StatelessWidget {
  const PathNodeRow({
    super.key,
    required this.index,
    required this.totalLevels,
    required this.item,
  });

  final int index;
  final int totalLevels;
  final PathLevelItem item;

  @override
  Widget build(BuildContext context) {
    final isLeftAligned = (totalLevels - 1 - index).isOdd;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment:
            isLeftAligned ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (!isLeftAligned) const Spacer(),
          PathNode(
            item: item,
            icon: item.isUnlocked ? Icons.check : Icons.lock_outline,
          ),
          if (isLeftAligned) const Spacer(),
        ],
      ),
    );
  }
}
