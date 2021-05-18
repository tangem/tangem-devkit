String stringOf(dynamic from, {String def = "", typed = false}) {
  if (from == null) return def;
  if (from is Iterable) {
    return from.map((dyn) => stringOf(dyn)).toList().toString();
  }
  return from is String ? from : typed ? from.runtimeType.toString() : from.toString();
}
