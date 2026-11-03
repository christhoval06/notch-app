import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/content_section.dart';
import 'package:notch_app/features/landing/services/landing_content_service.dart';
import 'package:notch_app/features/landing/widgets/landing_heading.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingFaq extends StatefulWidget {
  const LandingFaq({super.key});
  @override
  State<LandingFaq> createState() => _LandingFaqState();
}

class _LandingFaqState extends State<LandingFaq> {
  int? _open;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final questions = LandingContentService.questions(l);
    return ContentSection(
      color: scheme.surfaceContainerLow,
      maxWidth: 880,
      child: Column(
        children: [
          LandingHeading(
            label: l.landingFaqLabel,
            title: l.landingFaqTitle,
            centered: true,
            accent: scheme.secondary,
          ),
          const SizedBox(height: 32),
          for (var i = 0; i < questions.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Semantics(
                      expanded: _open == i,
                      child: InkWell(
                        onTap: () =>
                            setState(() => _open = _open == i ? null : i),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  questions[i].$1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                _open == i
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_open == i)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Text(questions[i].$2),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
