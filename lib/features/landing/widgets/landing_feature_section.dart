import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/content_section.dart';
import 'package:notch_app/features/landing/models/landing_feature.dart';
import 'package:notch_app/features/landing/widgets/landing_heading.dart';
import 'package:notch_app/features/landing/widgets/landing_phone.dart';

class LandingFeatureSection extends StatelessWidget {
  const LandingFeatureSection({
    super.key,
    required this.feature,
    required this.index,
  });
  final LandingFeature feature;
  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = [
      scheme.primary,
      scheme.secondary,
      scheme.tertiary,
      scheme.primary,
    ][index];
    return ContentSection(
      verticalPadding: 88,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 850;
          final copy = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LandingHeading(
                label: feature.label,
                title: feature.title,
                body: feature.body,
                accent: accent,
              ),
              const SizedBox(height: 28),
              for (final point in feature.points)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 18,
                          color: scheme.tertiary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(point)),
                      ],
                    ),
                  ),
                ),
            ],
          );
          final phones = LayoutBuilder(
            builder: (context, bounds) {
              final width = ((bounds.maxWidth - 30) / 2).clamp(60.0, 230.0);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LandingPhone(asset: feature.screens[0], width: width),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 38),
                    child: LandingPhone(
                      asset: feature.screens[1],
                      width: width,
                    ),
                  ),
                ],
              );
            },
          );
          if (compact) {
            return Column(children: [copy, const SizedBox(height: 40), phones]);
          }
          final pieces = [
            Expanded(child: copy),
            const SizedBox(width: 100),
            Expanded(child: phones),
          ];
          return Row(
            children: index.isEven ? pieces : pieces.reversed.toList(),
          );
        },
      ),
    );
  }
}
