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

extension OnObject<T> on T {
  bool isEnum() {
    final split = this.toString().split('.');
    return split.length > 1 && split[0] == this.runtimeType.toString();
  }
}