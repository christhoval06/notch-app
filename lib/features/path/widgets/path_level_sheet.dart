import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/core/utils/level_localization.dart';
import 'package:notch_app/features/path/services/path_view_model_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PathLevelSheet extends StatelessWidget {
  const PathLevelSheet({super.key, required this.item, required this.icon});

  final PathLevelItem item;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final nodeColor = item.isCurrent ? scheme.warning : scheme.primary;
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: nodeColor.withValues(alpha: 0.1),
              border: Border.all(color: nodeColor, width: 2),
            ),
            child: Icon(icon, color: nodeColor, size: 30),
          ),
          const SizedBox(height: 15),
          Text(
            localizeLevelName(l10n, item.rawLevelName),
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            l10n.pathUnlockedAtXp(item.xpRequired.toString()),
            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
          ),
          const SizedBox(height: 15),
          Text(
            localizeLevelDescription(l10n, item.rawLevelName),
            textAlign: TextAlign.center,
            style: TextStyle(color: scheme.onSurfaceVariant, height: 1.5),
          ),
        ],
      ),
    );
  }
}
