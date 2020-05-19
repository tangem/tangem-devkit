import 'dart:developer' as d;

import 'package:intl/intl.dart';

import 'u_of.dart';

class Logger {
  static Logger _instanse;

  static Logger get instance => _createOrGet();

  static Logger _createOrGet() {
    if (_instanse == null) _instanse = Logger();
    return _instanse;
  }

  final _allLogs = <String>[];

  List<String> get allLogs => _allLogs.map((item) => item).toList();

  Logger() {
    d.log("Logger: create instance");
  }

  logAction(dynamic from, dynamic message) {
    log("action", from, message);
  }

  logRoute(dynamic from, dynamic message) {
    log("route", from, message);
  }

  logD(dynamic from, dynamic message) {
    log("debug", from, message);
  }

  logE(dynamic from, dynamic message) {
    log("error", from, message);
  }

  log(String type, dynamic from, dynamic message) {
    final date = DateTime.now();
    final logDate = DateFormat.Hms().format(date);
    final logFrom = _clearFrom(stringOf(from));
    final convertedMessage = "[$logDate]:[$type]:[$logFrom]: $message";
    _allLogs.add(convertedMessage);
    d.log(convertedMessage, time: date, name: logFrom);
  }

  String _clearFrom(String from) => from.replaceAll(" ", "").replaceAll("Instanceof", "").replaceAll("'", "");
}

logAction(dynamic from, dynamic message) {
  Logger.instance.logAction(from, message);
}

logRoute(dynamic from, dynamic message) {
  Logger.instance.logRoute(from, message);
}

logD(dynamic from, dynamic message) {
  Logger.instance.logD(from, message);
}

logE(dynamic from, dynamic message) {
  Logger.instance.logE(from, message);
}
