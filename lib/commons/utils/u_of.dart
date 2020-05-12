
int intOf(dynamic from, {int def}) {
  if (from == null) return def;
  if (from is int) return from;
  if (from is String) {
    if (from.contains(".") || from.contains(",")) return doubleOf(from, def: 0.0).toInt();
    return int.tryParse(from);
  }
  if (from is num) return from.toInt();
  return def;
}

double doubleOf(dynamic from, {double def}) {
  if (from == null) return def;
  if (from is double) return from;
  if (from is String) return double.tryParse(from);
  if (from is num) return from.toDouble();
  return def;
}

String stringOf(dynamic from, [typed = false]) {
  if (from == null) return "";
  if (from is Iterable) {
    return from.map((dyn) => stringOf(dyn)).toList().toString();
  }
  return from is String ? from : typed ? from.runtimeType.toString() : from.toString();
}