import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/repositories/health_log_repository.dart';

class HealthLogsViewService {
  const HealthLogsViewService._();

  static List<HealthLog> getSortedLogs() {
    final logs = HealthLogRepository.getAll();
    logs.sort((first, second) => second.date.compareTo(first.date));
    return logs;
  }
}
