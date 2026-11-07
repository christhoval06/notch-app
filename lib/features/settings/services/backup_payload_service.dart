import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/models/partner.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BackupPayloadService {
  const BackupPayloadService._();

  static Map<String, dynamic> buildSnapshot() {
    return {
      'version': 1,
      'timestamp': DateTime.now().toIso8601String(),
      'encounters': _serializeEncounters(),
      'partners': _serializePartners(),
      'health': _serializeHealthLogs(),
    };
  }

  static Future<void> restore(Map<String, dynamic> data) async {
    await Hive.box<Encounter>(HiveBoxes.encounters).clear();
    await Hive.box<Partner>(HiveBoxes.partners).clear();
    await Hive.box<HealthLog>(HiveBoxes.healthLogs).clear();
    await Hive.box<MonthlyProgress>(HiveBoxes.monthlyProgress).clear();
    await Hive.box<GlobalProgress>(HiveBoxes.globalProgress).clear();

    for (final encounter in data['encounters'] as List<dynamic>? ?? const []) {
      Hive.box<Encounter>(
        HiveBoxes.encounters,
      ).add(_deserializeEncounter(Map<String, dynamic>.from(encounter as Map)));
    }

    for (final partner in data['partners'] as List<dynamic>? ?? const []) {
      Hive.box<Partner>(
        HiveBoxes.partners,
      ).add(_deserializePartner(Map<String, dynamic>.from(partner as Map)));
    }

    for (final health in data['health'] as List<dynamic>? ?? const []) {
      Hive.box<HealthLog>(
        HiveBoxes.healthLogs,
      ).add(_deserializeHealthLog(Map<String, dynamic>.from(health as Map)));
    }
  }

  static List<Map<String, dynamic>> _serializeEncounters() {
    return Hive.box<Encounter>(HiveBoxes.encounters).values.map((encounter) {
      return {
        'id': encounter.id,
        'date': encounter.date.toIso8601String(),
        'partnerName': encounter.partnerName,
        'orgasmCount': encounter.orgasmCount,
        'rating': encounter.rating,
        'tags': encounter.tags,
        'protected': encounter.protected,
        'moodEmoji': encounter.moodEmoji,
        'notes': encounter.notes,
      };
    }).toList();
  }

  static List<Map<String, dynamic>> _serializePartners() {
    return Hive.box<Partner>(HiveBoxes.partners).values.map((partner) {
      return {
        'id': partner.id,
        'name': partner.name,
        'notes': partner.notes,
        'avatarType': partner.avatarType.index,
        'avatarContent': partner.avatarContent,
      };
    }).toList();
  }

  static List<Map<String, dynamic>> _serializeHealthLogs() {
    return Hive.box<HealthLog>(HiveBoxes.healthLogs).values.map((healthLog) {
      return {
        'date': healthLog.date.toIso8601String(),
        'testType': healthLog.testType,
        'result': healthLog.result,
      };
    }).toList();
  }

  static Encounter _deserializeEncounter(Map<String, dynamic> data) {
    return Encounter(
      id: data['id'] as String,
      date: DateTime.parse(data['date'] as String),
      partnerName: data['partnerName'] as String,
      orgasmCount: data['orgasmCount'] as int,
      rating: data['rating'] as int,
      tags: List<String>.from(data['tags'] as List<dynamic>? ?? const []),
      protected: data['protected'] as bool? ?? true,
      moodEmoji: data['moodEmoji'] as String?,
      notes: data['notes'] as String?,
    );
  }

  static Partner _deserializePartner(Map<String, dynamic> data) {
    final avatarIndex = data['avatarType'] as int? ?? 0;
    final safeIndex = avatarIndex.clamp(0, AvatarType.values.length - 1);
    return Partner(
      id: data['id'] as String,
      name: data['name'] as String,
      notes: data['notes'] as String?,
      avatarType: AvatarType.values[safeIndex],
      avatarContent: data['avatarContent'] as String? ?? '',
    );
  }

  static HealthLog _deserializeHealthLog(Map<String, dynamic> data) {
    return HealthLog(
      date: DateTime.parse(data['date'] as String),
      testType: data['testType'] as String,
      result: data['result'] as String,
    );
  }
}
