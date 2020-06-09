import 'dart:ui';

import 'package:devkit/commons/utils/exp_utils.dart';
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
  static const itemTitleTextSize = 12.0;
  static const itemDescTextSize = 12.0;
  static const descPadding = 5.0;
}

class AppColor {
  static final Color primaryColor = Colors.blue[600];
  static final Color primaryDarkColor = Colors.blue[600];
  static final Color accentColor = Colors.blue[600];

//  static final Color primaryColor = Colors.purpleAccent;
//  static final Color primaryDarkColor = Colors.purpleAccent;
//  static final Color accentColor = Colors.purpleAccent;

  static final listDelimiter = Colors.grey.withAlpha(70);
  static final border = Colors.blueGrey.withAlpha(70);
  static final dropDownUnderline = Colors.grey;

  static final itemTitle = Colors.grey;
  static final itemDescription = Colors.grey;
  static final itemBgBlock = Colors.grey[350];

  static final responseCardData = HexColor("#D7E4F3");
  static final responseProductMask = HexColor("#D7E4F3");
  static final responseSettingsMask = HexColor("#D7F3E6");
}
