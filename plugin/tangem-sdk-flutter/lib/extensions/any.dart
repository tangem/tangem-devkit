import 'dart:convert';

extension Kotlin<T> on T {
  let(Function(T it) func) {
    final notNull = this;
    if (notNull != null) func(notNull);
  }

  T apply(Function(T it) bloc) {
    bloc(this);
    return this;
  }
}

extension Json<T> on T {
  String jsonEncode([bool withPrettyPrint = false, int indent = 4]) {
    final encoder =
        withPrettyPrint ? JsonEncoder.withIndent(List.generate(indent, (index) => " ").join()) : JsonEncoder();
    return encoder.convert(this);
  }
}

extension OnObject<T> on T {
  bool isEnum() {
    final split = this.toString().split('.');
    return split.length > 1 && split[0] == this.runtimeType.toString();
  }
}
