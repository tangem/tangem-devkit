import 'dart:convert';

import 'package:convert/convert.dart';

// bytes, hex
extension hexAndBytes on String {
  List<int> hexToBytes() {
    final length = this.length ~/ 2;
    return List.generate(length, (index) => int.parse(this.substring(2 * index, 2 * index + 2), radix: 16));
  }

  String hexToString() => utf8.decode(this.hexToBytes());

  String toHexString() => hex.encode(this.toBytes());

  List<int> toBytes() => this.codeUnits;

  List<String> splitToList({String delimiter = ",", List<String>? ifEmpty}) {
    if (this.isEmpty) return ifEmpty ?? [];

    if (this.contains(delimiter)) {
      return this.split(delimiter).toList().map((e) => e.trim()).toList();
    } else {
      return [this.trim()];
    }
  }
}

extension OnString on String? {
  bool isNullOrEmpty() {
    if (this == null)
      return true;
    else
      return this!.isEmpty;
  }
}

// iterables
extension OnIterableNullSafe<E> on Iterable<E> {
  E? firstWhereOrNull(bool test(E e)) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  E? firstOrNull() {
    return this.isEmpty ? null : this.first;
  }
}

extension OnIterable<E> on Iterable<E?>? {
  bool isNullOrEmpty() {
    if (this == null)
      return true;
    else
      return this!.isEmpty;
  }
}

// list
extension OnList<E> on List<E?> {
  List<E> toNullSafe() {
    return this.filterNotNull();
  }

  List<E> filterNotNull([dynamic checkField(E e)?]) {
    var nullSafeList = <E>[];
    if (checkField == null) {
      this.forEach((element) {
        if (element != null) nullSafeList.add(element);
      });
    } else {
      this.forEach((element) {
        if (element != null) {
          if (checkField(element) != null) nullSafeList.add(element);
        }
      });
    }
    return nullSafeList;
  }

  bool hasNull([dynamic checkForField(E e)?]) {
    if (checkForField == null) {
      for (var value in this) {
        if (value == null) return true;
      }
    } else {
      for (var value in this) {
        if (value != null) {
          if (checkForField(value) == null) return true;
        }
      }
    }
    return false;
  }

  List<int> toIntList() => this.map((e) => int.tryParse(e?.toString() ?? "")).toList().toNullSafe();

  List<String> toStringList() => this.map((e) => e?.toString()).toList().toNullSafe();
}

extension OnListNullSafe<E> on List<E> {
  List<T> mapIndexed<T>(T transform(int index, E e)) {
    final newList = <T>[];
    for (int i = 0; i < length; i++) {
      newList.add(transform(i, this[i]));
    }
    return newList;
  }

  safeAdd(E? element) {
    if (element != null) this.add(element);
  }
}

extension ByteArrayToHex on List<int> {
  String toHexString() => hex.encode(this);
}

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
