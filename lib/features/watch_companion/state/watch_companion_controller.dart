import 'package:notch_app/data/repositories/partner_repository.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:notch_app/core/session/app_access_session.dart';
import 'package:notch_app/core/utils/locale_controller.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/monthly_progress_repository.dart';
import 'package:notch_app/features/watch_companion/services/watch_command.dart';
import 'package:notch_app/features/watch_companion/services/watch_import_service.dart';
import 'package:notch_app/features/watch_companion/services/watch_snapshot_cache.dart';
import 'package:notch_app/features/watch_companion/services/watch_snapshot_service.dart';
import 'package:notch_app/features/watch_companion/services/watch_transport.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class WatchCompanionController {
  WatchCompanionController._();
  static final instance = WatchCompanionController._();
  final _access = AppAccessSession.instance;
  final _cache = WatchSnapshotCache();
  WatchTransport? _transport;
  bool _busy = false, _again = false;
  String _generation = '';

  Future<void> start() async {
    if (kIsWeb ||
        defaultTargetPlatform != TargetPlatform.iOS ||
        _transport != null) {
      return;
    }
    final transport = WatchTransport();
    _transport = transport;
    transport.onInbox = () => unawaited(drainInbox());
    _access.addListener(_accessChanged);
    EncounterRepository.listenable().addListener(_dataChanged);
    MonthlyProgressRepository.listenable().addListener(_dataChanged);
    PartnerRepository.listenable().addListener(_dataChanged);
    AppLocaleController.instance.localeNotifier.addListener(_dataChanged);
    Timer.periodic(const Duration(minutes: 1), (_) {
      if (_access.canImport) unawaited(drainInbox());
    });
    try {
      await transport.activate();
    } catch (error) {
      debugPrint('Watch activate: $error');
    }
  }

  void _dataChanged() {
    _cache.invalidate();
    unawaited(drainInbox());
  }

  void _accessChanged() {
    if (_access.value == AppAccess.decoy) {
      unawaited(_disable());
    } else if (_access.canImport) {
      _cache.invalidate();
      unawaited(drainInbox());
    }
  }

  Future<void> _disable() async {
    try {
      await _transport?.publish({'state': 'disabled'});
    } catch (error) {
      debugPrint('Watch disable: $error');
    }
  }

  Future<void> drainInbox() async {
    if (_transport == null || !_access.canImport) return;
    if (_busy) {
      _again = true;
      return;
    }
    _busy = true;
    try {
      do {
        _again = false;
        final pairing = await _transport!.pairing();
        _generation = pairing['generation'] as String? ?? '';
        if (_generation.isEmpty || !_access.canImport) break;
        final importer = WatchImportService(
          generation: () => _generation,
          canImport: () => _access.canImport,
          now: DateTime.now,
        );
        for (final payload in await _transport!.inbox()) {
          if (!_access.canImport) break;
          try {
            final receipt = await importer.import(
              WatchCommand.fromMap(payload),
            );
            if (receipt != null) await _transport!.complete(receipt.toMap());
          } on FormatException {
            await _transport!.complete({
              ...payload,
              'kind': 'receipt',
              'status': 'rejected',
              'reason': 'invalid_entry',
            });
          }
        }
        if (_access.canImport) await _publish();
      } while (_again && _access.canImport);
    } catch (error) {
      debugPrint('Watch sync deferred: $error');
    } finally {
      _busy = false;
    }
  }

  Future<void> _publish() async {
    _cache.refresh();
    final snapshot = WatchSnapshotService.build(
      now: DateTime.now(),
      encounters: _cache.encounters,
      monthlyProgress: _cache.monthlyProgress,
      partnerNames: _cache.partnerNames,
      l10n: lookupAppLocalizations(
        AppLocaleController.instance.localeNotifier.value,
      ),
      generation: _generation,
      revision: 0,
    );
    if (_access.canImport) await _transport!.publish(snapshot.toMap());
  }

  Future<void> reset() async {
    _access.lock();
    _generation = '';
    _cache.invalidate();
    // Throw on native reset failure: erasure must not proceed with a valid old generation.
    if (_transport != null) await _transport!.rotate();
  }
}
