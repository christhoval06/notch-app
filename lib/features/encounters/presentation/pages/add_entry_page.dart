import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/core/utils/achievement_localization.dart';
import 'package:notch_app/features/encounters/services/add_entry_submission_service.dart';
import 'package:notch_app/features/encounters/widgets/add_entry_form.dart';
import 'package:notch_app/features/gamification/services/achievement_engine.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  String _partnerDraftValue = '';
  double _lastHapticValue = 8.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.save),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: scheme.primary),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: AddEntryForm(
          formKey: _formKey,
          partnerDraftValue: _partnerDraftValue,
          lastHapticValue: _lastHapticValue,
          onPartnerDraftChanged: (value) {
            setState(() => _partnerDraftValue = value);
          },
          onRatingChanged: (value) {
            setState(() => _lastHapticValue = value);
          },
          onSubmit: _submitForm,
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final result = await AddEntrySubmissionService.submit(
      formKey: _formKey,
      partnerDraftValue: _partnerDraftValue,
    );
    if (!mounted) return;

    switch (result.status) {
      case AddEntrySubmissionStatus.invalidPartner:
        HapticFeedback.vibrate();
        return;
      case AddEntrySubmissionStatus.limitReached:
        HapticFeedback.mediumImpact();
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.liteMonthlyEncounterLimitReached)),
        );
        return;
      case AddEntrySubmissionStatus.saved:
        HapticFeedback.heavyImpact();
        Navigator.of(context).pop();
        await _showUnlockedAchievements(result.achievements);
        return;
    }
  }

  Future<void> _showUnlockedAchievements(List<Achievement> achievements) async {
    if (achievements.isEmpty) return;

    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final scheme = Theme.of(context).colorScheme;
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    for (final achievement in achievements) {
      messenger.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Text(achievement.icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.achievementUnlockedTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: scheme.onPrimary,
                      ),
                    ),
                    Text(
                      localizeAchievementName(
                        l10n,
                        achievement.id,
                        achievement.name,
                      ),
                      style: TextStyle(
                        color: scheme.onPrimary.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: scheme.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 3),
        ),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;
    }
  }
}
