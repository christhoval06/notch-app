import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/features/feature/encounters/services/lite_mode_service.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine.dart';
import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:uuid/uuid.dart';

enum AddEntrySubmissionStatus { saved, invalidPartner, limitReached }

class AddEntrySubmissionResult {
  const AddEntrySubmissionResult({
    required this.status,
    this.achievements = const [],
  });

  final AddEntrySubmissionStatus status;
  final List<Achievement> achievements;
}

class AddEntrySubmissionService {
  const AddEntrySubmissionService._();

  static Future<AddEntrySubmissionResult> submit({
    required GlobalKey<FormBuilderState> formKey,
    required String partnerDraftValue,
  }) async {
    if (!(formKey.currentState?.saveAndValidate() ?? false)) {
      return const AddEntrySubmissionResult(
        status: AddEntrySubmissionStatus.invalidPartner,
      );
    }

    final values = formKey.currentState!.value;
    final partnerName = _resolvePartnerName(values, partnerDraftValue);
    if (partnerName.isEmpty) {
      return const AddEntrySubmissionResult(
        status: AddEntrySubmissionStatus.invalidPartner,
      );
    }

    final encounterDate = DateTime.now();
    final encounters = EncounterRepository.getAll();
    if (!LiteModeService.canAddEncounter(
      encounters: encounters,
      date: encounterDate,
    )) {
      return const AddEntrySubmissionResult(
        status: AddEntrySubmissionStatus.limitReached,
      );
    }

    final encounter = Encounter(
      id: const Uuid().v4(),
      date: encounterDate,
      partnerName: partnerName,
      rating: values['rating'] as int,
      orgasmCount: values['orgasmCount'] as int? ?? 0,
      tags: List<String>.from(values['tags'] as List<dynamic>? ?? const []),
      moodEmoji: values['moodEmoji'] as String?,
      protected: values['protected'] as bool? ?? true,
    );

    await EncounterRepository.put(encounter);
    final achievements = await GamificationEngine.processEncounter(encounter);
    return AddEntrySubmissionResult(
      status: AddEntrySubmissionStatus.saved,
      achievements: achievements,
    );
  }

  static String _resolvePartnerName(
    Map<String, dynamic> values,
    String partnerDraftValue,
  ) {
    final partnerFromForm = (values['partnerName'] as String? ?? '').trim();
    final partnerName = partnerFromForm.isNotEmpty
        ? partnerFromForm
        : partnerDraftValue.trim();
    return partnerName.replaceFirst(RegExp(r'^[@＠]'), '');
  }
}
