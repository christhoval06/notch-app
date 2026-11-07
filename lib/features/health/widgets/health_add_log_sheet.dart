import 'package:flutter/material.dart';
import 'package:notch_app/features/health/services/health_log_submission_service.dart';
import 'package:notch_app/features/health/widgets/health_add_log_sheet_header.dart';
import 'package:notch_app/features/health/widgets/health_result_choice_row.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class HealthAddLogSheet extends StatefulWidget {
  const HealthAddLogSheet({super.key});

  @override
  State<HealthAddLogSheet> createState() => _HealthAddLogSheetState();
}

class _HealthAddLogSheetState extends State<HealthAddLogSheet> {
  final _testTypeController = TextEditingController();
  String? _result;
  final _selectedDate = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _result ??= AppLocalizations.of(context).healthResultNegative;
  }

  @override
  void dispose() {
    _testTypeController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_testTypeController.text.isEmpty) return;
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final result = await HealthLogSubmissionService.submit(
      l10n: l10n,
      date: _selectedDate,
      testType: _testTypeController.text,
      result: _result!,
    );
    if (!mounted) return;
    navigator.pop();
    if (result.unlockedMessage != null) {
      messenger.showSnackBar(SnackBar(content: Text(result.unlockedMessage!)));
    }
    messenger.showSnackBar(
      SnackBar(
        content: Text(result.savedMessage),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HealthAddLogSheetHeader(),
            const SizedBox(height: 20),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _testTypeController,
                  style: TextStyle(color: scheme.onSurface),
                  decoration: InputDecoration(
                    labelText: l10n.healthTestTypeLabel,
                    labelStyle: TextStyle(color: scheme.onSurfaceVariant),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: HealthResultChoiceRow(
                  selectedResult: _result!,
                  onChanged: (value) => setState(() => _result = value),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                icon: const Icon(Icons.save_outlined),
                label: Text(l10n.healthSaveAndSchedule),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: _save,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
