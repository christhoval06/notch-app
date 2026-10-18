import 'package:flutter/material.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class ChallengeMetaRow extends StatelessWidget {
  const ChallengeMetaRow({
    super.key,
    required this.challenge,
    this.highlighted = false,
  });

  final Challenge challenge;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final familyLabel = challenge.family == ChallengeFamily.seasonal
        ? l10n.challengeSeasonal
        : l10n.challengeHistorical;
    final familyBg = challenge.family == ChallengeFamily.seasonal
        ? scheme.primary.withValues(alpha: 0.12)
        : scheme.tertiary.withValues(alpha: 0.12);
    final familyFg = challenge.family == ChallengeFamily.seasonal
        ? scheme.primary
        : scheme.tertiary;
    final xpBg = highlighted
        ? scheme.secondary.withValues(alpha: 0.14)
        : scheme.scrim.withValues(alpha: 0.24);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _MetaChip(
          label: familyLabel,
          background: familyBg,
          foreground: familyFg,
        ),
        _MetaChip(
          label: l10n.challengeXpReward(challenge.xpReward.toString()),
          background: xpBg,
          foreground: scheme.onSurface,
        ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
