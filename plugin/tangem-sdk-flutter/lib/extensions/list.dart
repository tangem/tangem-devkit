import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:tangem_sdk/extensions/any.dart';

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

  List<T> mapNotNull<T>(T? transform(E e)) {
    var nullSafeList = <T>[];
    this.forEach((element) {
      if (element != null) {
        final result = transform(element);
        if (result != null) nullSafeList.add(result);
      }
    });
    return nullSafeList;
  }

  E? removeFirstOrNull() => this.isEmpty ? null : removeAt(0);

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

  List<String> enumToStringList() {
    return this.map((e) => e != null && e.isEnum() ? describeEnum(e) : null).toList().toNullSafe();
  }
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
