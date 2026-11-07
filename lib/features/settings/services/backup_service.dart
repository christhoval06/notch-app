import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/features/settings/services/backup_payload_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BackupService {
  static final key = enc.Key.fromUtf8(
    'm3kksIoMg6WLIO1JdqV2CeFrT6062JKE'.padRight(32, '*').substring(0, 32),
  );
  static final iv = enc.IV.fromLength(16);
  static final encrypter = enc.Encrypter(enc.AES(key));

  Future<void> createEncryptedBackup() async {
    try {
      final jsonString = jsonEncode(BackupPayloadService.buildSnapshot());
      final encrypted = encrypter.encrypt(jsonString, iv: iv);
      final dir = await getTemporaryDirectory();
      final dateStr = DateFormat('yyyyMMdd_HHmm').format(DateTime.now());
      final file = File('${dir.path}/backup_notch_$dateStr.notch');
      await file.writeAsString('${iv.base64}:${encrypted.base64}');
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'Copia de seguridad NOTCH',
        ),
      );
    } catch (error, stackTrace) {
      _log('createEncryptedBackup failed: $error');
      _log(stackTrace.toString());
      throw Exception('Error al crear backup');
    }
  }

  Future<bool> restoreBackup() async {
    try {
      final file = await openFile();
      if (file == null) return false;

      final parts = (await file.readAsString()).split(':');
      if (parts.length != 2) throw const FormatException('Formato inválido');

      final decryptedString = encrypter.decrypt(
        enc.Encrypted.fromBase64(parts[1]),
        iv: enc.IV.fromBase64(parts[0]),
      );

      await BackupPayloadService.restore(
        Map<String, dynamic>.from(jsonDecode(decryptedString) as Map),
      );
      return true;
    } catch (error, stackTrace) {
      _log('restoreBackup failed: $error');
      _log(stackTrace.toString());
      return false;
    }
  }

  void _log(String message) {
    debugPrint('[BackupService] $message');
  }
}
