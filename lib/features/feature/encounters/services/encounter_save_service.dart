import 'package:notch_app/core/services/encounter_write_coordinator.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/features/feature/encounters/services/lite_mode_service.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_models.dart';
import 'package:notch_app/features/feature/gamification/services/encounter_progress_reconciliation_service.dart';

class EncounterSaveResult {
  const EncounterSaveResult(this.saved, [this.achievements = const []]);
  final bool saved;
  final List<Achievement> achievements;
}

abstract final class EncounterSaveService {
  static Future<EncounterSaveResult> save(Encounter encounter) =>
      EncounterWriteCoordinator.run(() => saveWithinWrite(encounter));

  static Future<EncounterSaveResult> saveWithinWrite(
    Encounter encounter, {
    DateTime? now,
  }) async {
    final existing = EncounterRepository.getById(encounter.id);
    if (existing == null &&
        !LiteModeService.canAddEncounter(
          encounters: EncounterRepository.getAll(),
          date: encounter.date,
        )) {
      return const EncounterSaveResult(false);
    }
    if (existing == null) await EncounterRepository.put(encounter);
    final achievements = await EncounterProgressReconciliationService.reconcile(
      eventDate: encounter.date,
      now: now,
    );
    return EncounterSaveResult(true, achievements);
  }
}
