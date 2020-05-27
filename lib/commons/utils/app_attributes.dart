import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App {
  static const isDebug = !kReleaseMode;
  static PlatformType platformType;

  static forceClose() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

enum PlatformType { IOS, ANDROID, UNKNOWN }

class AppDimen {
  static const double toolbarHeight = 55;
  static const double toolbarBorderRadius = 16;

  static const itemMinHeight = 52.0;
  static const itemTextSize = 16.0;
  static const itemDescTextSize = 12;
}

class AppColor {
  static final Color primaryColor = Colors.blueGrey;
  static final Color primaryDarkColor = Colors.blueGrey[700];
  static final Color accentColor = Colors.blueGrey[700];

  static final listDelimiter = Colors.grey;
  static final dropDownUnderline = Colors.grey;

  static final itemTitle = Colors.grey;
  static final itemDescription = Colors.grey;
  static final itemBgBlock = Colors.grey[350];
}
