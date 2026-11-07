class WatchSnapshot {
  WatchSnapshot(Map<String, Object?> fields)
    : fields = Map.unmodifiable(fields);
  final Map<String, Object?> fields;
  Map<String, Object?> toMap() => fields;
}
