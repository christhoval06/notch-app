abstract final class WatchDashboardCards {
  static const abstinence = 'abstinence';
  static const level = 'level';
  static const stats = 'stats';
  static const orgasms = 'orgasms';
  static const all = [abstinence, level, stats, orgasms];
  static const defaults = [abstinence, level, stats];

  static List<String> normalize(Iterable<Object?> values) =>
      List.unmodifiable(values.whereType<String>().where(all.contains).toSet());
}
