extension OnMap<K, V> on Map<K, V?> {
  bool hasNull([dynamic checkForField(dynamic value)?]) {
    if (checkForField == null) {
      for (var value in this.values) {
        if (value == null) return true;
      }
    } else {
      for (var value in this.values) {
        if (value != null) {
          if (checkForField(value) == null) return true;
        }
      }
    }
    return false;
  }
}