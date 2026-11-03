import 'package:flutter/material.dart';
import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/repositories/monthly_progress_repository.dart';
import 'package:notch_app/features/feature/path/services/path_view_model_service.dart';
import 'package:notch_app/features/feature/path/widgets/path_content.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PathView extends StatefulWidget {
  const PathView({super.key});

  @override
  State<PathView> createState() => _PathViewState();
}

class _PathViewState extends State<PathView> {
  late final List<GlobalKey> _nodeKeys;
  final _scrollController = ScrollController();
  var _lastScrolledIndex = -1;

  @override
  void initState() {
    super.initState();
    _nodeKeys = List.generate(GamificationEngine.levels.length, (_) => GlobalKey());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentLevel(int currentLevelIndex) {
    if (_lastScrolledIndex == currentLevelIndex) return;
    _lastScrolledIndex = currentLevelIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final realIndex = GamificationEngine.levels.length - 1 - currentLevelIndex;
      final currentContext = _nodeKeys[realIndex].currentContext;
      if (currentContext == null) return;
      Scrollable.ensureVisible(
        currentContext,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.5,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ValueListenableBuilder(
      valueListenable: MonthlyProgressRepository.listenable(),
      builder: (context, _, _) {
        return FutureBuilder<MonthlyProgress>(
          future: GamificationEngine.getCurrentMonthlyProgress(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final viewModel = PathViewModelService.build(snapshot.data!);
            _scrollToCurrentLevel(viewModel.currentLevelIndex);
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text(l10n.pathTitle),
              ),
              body: PathContent(
                nodeKeys: _nodeKeys,
                scrollController: _scrollController,
                viewModel: viewModel,
              ),
            );
          },
        );
      },
    );
  }
}
