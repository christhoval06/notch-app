import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/path/services/path_view_model_service.dart';
import 'package:notch_app/features/feature/path/widgets/path_node_row.dart';
import 'package:notch_app/features/feature/path/widgets/path_progress_painter.dart';

class PathContent extends StatelessWidget {
  const PathContent({
    super.key,
    required this.nodeKeys,
    required this.scrollController,
    required this.viewModel,
  });

  final List<GlobalKey> nodeKeys;
  final ScrollController scrollController;
  final PathViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: PathProgressPainter(
              progress: viewModel.totalProgress.clamp(0.0, 1.0),
              backgroundColor: scheme.outlineVariant,
              gradientTop: scheme.primary,
              gradientBottom: scheme.secondary,
            ),
          ),
        ),
        ListView.builder(
          controller: scrollController,
          reverse: true,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          itemCount: viewModel.levels.length,
          itemBuilder: (context, index) {
            return Container(
              key: nodeKeys[index],
              child: PathNodeRow(
                index: index,
                totalLevels: viewModel.levels.length,
                item: viewModel.levels[index],
              ),
            );
          },
        ),
      ],
    );
  }
}
