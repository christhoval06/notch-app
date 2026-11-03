import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/content_section.dart';
import 'package:notch_app/features/landing/services/landing_content_service.dart';
import 'package:notch_app/features/landing/widgets/landing_heading.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingArchitecture extends StatelessWidget {
  const LandingArchitecture({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return ContentSection(
      color: scheme.surfaceContainerLow,
      child: Column(
        children: [
          LandingHeading(
            label: l.landingArchitectureLabel,
            title: l.landingArchitectureTitle,
            body: l.landingArchitectureBody,
            centered: true,
            accent: scheme.tertiary,
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: constraints.maxWidth < 700 ? 700 : constraints.maxWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(.9),
                      1: FlexColumnWidth(1.3),
                      2: FlexColumnWidth(1.2),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                        ),
                        children: [
                          for (final title in [
                            l.landingArchitectureVector,
                            l.landingArchitectureNotch,
                            l.landingArchitectureOther,
                          ])
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      for (final row in LandingContentService.comparisons(l))
                        TableRow(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: scheme.outlineVariant.withValues(
                                  alpha: .2,
                                ),
                              ),
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(row.$1),
                            ),
                            Container(
                              color: scheme.tertiary.withValues(alpha: .05),
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: scheme.tertiary,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      row.$2,
                                      style: TextStyle(
                                        color: scheme.tertiary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: scheme.error.withValues(alpha: .03),
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                row.$3,
                                style: TextStyle(
                                  color: scheme.onSurfaceVariant,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
