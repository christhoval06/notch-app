import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    required this.title,
    required this.topInset,
    required this.showPathAction,
    required this.showInsightsAction,
    required this.onSettingsTap,
    required this.onPathTap,
    required this.onInsightsTap,
    super.key,
  });

  final String title;
  final double topInset;
  final bool showPathAction;
  final bool showInsightsAction;
  final VoidCallback onSettingsTap;
  final VoidCallback onPathTap;
  final VoidCallback onInsightsTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final background = Theme.of(context).scaffoldBackgroundColor;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: background,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Container(
        height: topInset + kToolbarHeight,
        padding: EdgeInsets.only(top: topInset),
        color: background,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.settings, color: scheme.onSurface),
              onPressed: onSettingsTap,
            ),
            if (showPathAction)
              IconButton(
                icon: Icon(Icons.map, color: scheme.onSurface),
                onPressed: onPathTap,
              ),
            if (showInsightsAction)
              IconButton(
                icon: Icon(Icons.psychology, color: scheme.onSurface),
                onPressed: onInsightsTap,
              ),
          ],
        ),
      ),
    );
  }
}
