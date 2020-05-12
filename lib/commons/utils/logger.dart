import 'dart:developer' as d;

import 'u_of.dart';

logD(dynamic from, dynamic message) {
  String fromStr = stringOf(from);
  d.log("[${_clearFrom(fromStr)}]: $message");
}

String _clearFrom(String from) => from.replaceAll(" ", "").replaceAll("Instanceof", "").replaceAll("'", "");
