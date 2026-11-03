import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/core/utils/level_localization.dart';
import 'package:notch_app/features/feature/path/services/path_view_model_service.dart';
import 'package:notch_app/features/feature/path/widgets/path_level_sheet.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PathNode extends StatefulWidget {
  const PathNode({super.key, required this.item, required this.icon});

  final PathLevelItem item;
  final IconData icon;

  @override
  State<PathNode> createState() => _PathNodeState();
}

class _PathNodeState extends State<PathNode> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (widget.item.isCurrent) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant PathNode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item.isCurrent == oldWidget.item.isCurrent) return;
    if (widget.item.isCurrent) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showLevelSheet() async {
    if (!widget.item.isUnlocked) return;
    HapticFeedback.mediumImpact();
    await showModalBottomSheet<void>(
      context: context,
      builder: (_) => PathLevelSheet(item: widget.item, icon: widget.icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final levelName = localizeLevelName(l10n, widget.item.rawLevelName);
    final activeColor = widget.item.isCurrent ? scheme.warning : scheme.primary;
    final nodeColor = widget.item.isUnlocked ? activeColor : scheme.outlineVariant;

    return GestureDetector(
      onTap: _showLevelSheet,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: nodeColor.withValues(alpha: 0.2),
                  border: Border.all(color: nodeColor, width: 2),
                  boxShadow: _buildShadows(nodeColor),
                ),
                child: Icon(widget.icon, color: nodeColor, size: 30),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            levelName,
            style: TextStyle(
              fontFamily: 'Lato',
              color: widget.item.isUnlocked ? scheme.onSurface : scheme.outline,
              fontWeight: widget.item.isCurrent ? FontWeight.bold : FontWeight.normal,
              shadows: widget.item.isCurrent
                  ? [Shadow(color: nodeColor.withValues(alpha: 0.5), blurRadius: 10)]
                  : null,
            ),
          ),
          Text(
            '${widget.item.xpRequired} XP',
            style: TextStyle(
              fontFamily: 'Lato',
              color: widget.item.isUnlocked
                  ? nodeColor.withValues(alpha: 0.8)
                  : scheme.outline,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  List<BoxShadow>? _buildShadows(Color nodeColor) {
    if (widget.item.isCurrent) {
      return [
        BoxShadow(
          color: nodeColor.withValues(alpha: 0.5 + (_animation.value * 0.3)),
          blurRadius: 15 + (_animation.value * 10),
          spreadRadius: 2,
        ),
      ];
    }
    if (widget.item.isUnlocked) {
      return [
        BoxShadow(
          color: nodeColor.withValues(alpha: 0.5),
          blurRadius: 15,
        ),
      ];
    }
    return null;
  }
}
