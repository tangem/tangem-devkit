import 'dart:convert';

import 'package:convert/convert.dart';

extension OnStringNullSafe on String {
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

  String capitalize() {
    if (this.isEmpty) return this;

    final firstChar = this[0];
    return this.replaceRange(0, 1, firstChar.toUpperCase());
  }

  String wrap({String begin = "", String end = ""}) {
    return "$begin${this}$end";
  }

  String wrapBrackets() {
    return this.wrap(begin: "[", end: "]");
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
