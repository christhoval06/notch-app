import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';

class PartnerHistoryService {
  const PartnerHistoryService._();

  static List<Encounter> getHistory(String partnerName) {
    final history = EncounterRepository.getAll()
        .where((encounter) => encounter.partnerName == partnerName)
        .toList();
    history.sort((first, second) => second.date.compareTo(first.date));
    return history;
  }
}
