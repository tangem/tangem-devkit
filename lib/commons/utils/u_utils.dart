import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

final int UNDEFINED = -1;

Future<T> emptyFuture<T>() => Future.value(null);

int randomRange(int min, int max) => min + Random().nextInt(max - min);

Locale getLocale(BuildContext context) => Localizations.localeOf(context);

String getLocaleCountryCode(BuildContext context) => getLocale(context).countryCode;

String getLocaleLanguageCode(BuildContext context) => getLocale(context).languageCode;

double normalizeOpacity(double value) => value < 0 ? 0 : value > 1.0 ? 1.0 : value;

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

String enumToString(Object entry) => ReCase(describeEnum(entry)).camelCase;

String toEnumString(String entry) => ReCase(entry).constantCase;
