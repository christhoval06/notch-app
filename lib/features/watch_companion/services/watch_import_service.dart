import 'dart:convert';
import 'package:notch_app/core/services/encounter_write_coordinator.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/watch_import_repository.dart';
import 'package:notch_app/features/feature/encounters/services/encounter_save_service.dart';
import 'package:notch_app/features/watch_companion/services/watch_command.dart';
import 'package:notch_app/features/watch_companion/services/watch_receipt.dart';

class WatchImportService {
  WatchImportService({
    required this.generation,
    required this.canImport,
    required this.now,
  });
  final String Function() generation;
  final bool Function() canImport;
  final DateTime Function() now;

  Future<WatchReceipt?> import(WatchCommand command) =>
      EncounterWriteCoordinator.run(() async {
        if (!canImport()) return null;
        WatchReceipt receipt(String status, [String? reason]) => WatchReceipt(
          generation: command.generation,
          id: command.id,
          status: status,
          reason: reason,
        );
        if (command.generation != generation()) {
          return receipt('rejected', 'reset');
        }
        final error = command.validate(now());
        if (error != null) return receipt('rejected', error);
        final fingerprint = jsonEncode(command.toMap());
        final journal = WatchImportRepository.get(command.id);
        if (journal != null && journal['fingerprint'] != fingerprint) {
          return receipt('rejected', 'conflicting_id');
        }
        if (journal?['receipt'] case final Map previous) {
          return WatchReceipt.fromMap(Map<String, Object?>.from(previous));
        }
        final id = 'watch-${command.id}';
        final existing = EncounterRepository.getById(id);
        if (existing != null &&
            (existing.partnerName != command.partnerLabel ||
                existing.date != command.capturedAt ||
                existing.rating != command.rating ||
                existing.orgasmCount != command.orgasmCount ||
                existing.protected != command.protected)) {
          return receipt('rejected', 'conflicting_id');
        }
        await WatchImportRepository.put(command.id, {
          'fingerprint': fingerprint,
          'stage': 'received',
        });
        if (!canImport() || command.generation != generation()) return null;
        final encounter =
            existing ??
            Encounter(
              id: id,
              date: command.capturedAt,
              partnerName: command.partnerLabel,
              rating: command.rating,
              orgasmCount: command.orgasmCount,
              protected: command.protected,
            );
        final saved = await EncounterSaveService.saveWithinWrite(
          encounter,
          now: now(),
        );
        final result = saved.saved
            ? receipt('accepted')
            : receipt('rejected', 'limit_reached');
        await WatchImportRepository.put(command.id, {
          'fingerprint': fingerprint,
          'stage': 'completed',
          'receipt': result.toMap(),
        });
        return result;
      });
}
