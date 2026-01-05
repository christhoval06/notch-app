import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/encounter.dart';
import '../models/partner.dart';
import '../models/health_log.dart';

class BackupService {
  // 🔑 CLAVE DE ENCRIPTACIÓN (IMPORTANTE)
  // En una app real, podrías pedir al usuario que ingrese una contraseña.
  // Aquí usaremos una clave fija interna para simplificar el ejemplo,
  // pero lo ideal es derivarla de un input del usuario.
  // Debe tener 32 chars
  static final key = enc.Key.fromUtf8(
    'm3kksIoMg6WLIO1JdqV2CeFrT6062JKE'.padRight(32, '*').substring(0, 32),
  );
  static final iv = enc.IV.fromLength(16);
  static final encrypter = enc.Encrypter(enc.AES(key));

  // --- 1. EXPORTAR BACKUP ---
  Future<void> createEncryptedBackup() async {
    try {
      // A. Recopilar todos los datos en un Mapa gigante
      final encounters = Hive.box<Encounter>('encounters').values
          .map(
            (e) => {
              'id': e.id,
              'date': e.date.toIso8601String(),
              'partnerName': e.partnerName,
              'orgasmCount': e.orgasmCount,
              'rating': e.rating,
              'tags': e.tags,
              'protected': e.protected,
              'moodEmoji': e.moodEmoji,
              'notes': e.notes,
            },
          )
          .toList();

      final partners = Hive.box<Partner>('partners').values
          .map((p) => {'id': p.id, 'name': p.name, 'notes': p.notes})
          .toList();

      final health = Hive.box<HealthLog>('health_logs').values
          .map(
            (h) => {
              'date': h.date.toIso8601String(),
              'testType': h.testType,
              'result': h.result,
            },
          )
          .toList();

      final fullData = {
        'version': 1,
        'timestamp': DateTime.now().toIso8601String(),
        'encounters': encounters,
        'partners': partners,
        'health': health,
      };

      // B. Convertir a JSON String
      final jsonString = jsonEncode(fullData);

      // C. Encriptar (AES)
      final encrypted = encrypter.encrypt(jsonString, iv: iv);

      // D. Guardar en archivo temporal
      final dir = await getTemporaryDirectory();
      final dateStr = DateFormat('yyyyMMdd_HHmm').format(DateTime.now());
      final file = File('${dir.path}/backup_notch_$dateStr.notch');

      // Guardamos el IV + Texto Cifrado (separados por un punto o formato propio)
      // Formato simple: base64(iv) : base64(encrypted)
      final content = "${iv.base64}:${encrypted.base64}";
      await file.writeAsString(content);

      // E. Compartir / Guardar
      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Copia de seguridad NOTCH');
    } catch (e) {
      print("Error creando backup: $e");
      throw Exception("Error al crear backup");
    }
  }

  // --- 2. RESTAURAR BACKUP ---
  Future<bool> restoreBackup() async {
    try {
      // A. Seleccionar archivo
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return false;

      final file = File(result.files.single.path!);
      final content = await file.readAsString();

      // B. Desencriptar
      // Separamos IV y Data
      final parts = content.split(':');
      if (parts.length != 2) throw Exception("Formato inválido");

      final ivRestored = enc.IV.fromBase64(parts[0]);
      final encryptedData = enc.Encrypted.fromBase64(parts[1]);

      // Usamos el mismo encrypter pero con el IV restaurado (o el fijo si usas fijo)
      // Nota: Si usas IV aleatorio al guardar, debes leerlo aquí. En este ejemplo usamos IV fijo arriba,
      // pero lo correcto en seguridad es leer el IV del archivo.
      // Vamos a re-inicializar el encrypter para desencriptar
      final decryptedString = encrypter.decrypt(encryptedData, iv: ivRestored);

      // C. Convertir JSON a Objetos
      final data = jsonDecode(decryptedString);

      // D. BORRAR DATOS ACTUALES E INSERTAR LOS NUEVOS (Restauración completa)
      // ¡CUIDADO! Esto reemplaza todo.
      await Hive.box<Encounter>('encounters').clear();
      await Hive.box<Partner>('partners').clear();
      await Hive.box<HealthLog>('health_logs').clear();

      // Rellenar Encuentros
      for (var e in data['encounters']) {
        Hive.box<Encounter>('encounters').add(
          Encounter(
            id: e['id'],
            date: DateTime.parse(e['date']),
            partnerName: e['partnerName'],
            orgasmCount: e['orgasmCount'],
            rating: e['rating'],
            tags: List<String>.from(e['tags'] ?? []),
            protected: e['protected'] ?? true,
            moodEmoji: e['moodEmoji'],
            notes: e['notes'],
          ),
        );
      }

      // Rellenar Partners
      for (var p in data['partners']) {
        Hive.box<Partner>(
          'partners',
        ).add(Partner(id: p['id'], name: p['name'], notes: p['notes']));
      }

      // Rellenar Health
      for (var h in data['health']) {
        Hive.box<HealthLog>('health_logs').add(
          HealthLog(
            date: DateTime.parse(h['date']),
            testType: h['testType'],
            result: h['result'],
          ),
        );
      }

      return true;
    } catch (e) {
      print("Error restaurando: $e");
      return false;
    }
  }
}
