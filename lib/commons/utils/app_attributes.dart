import 'dart:ui';

import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App {
  static const isDebug = !kReleaseMode;
  // static PlatformType platformType;

  static forceClose() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

enum PlatformType { IOS, ANDROID, UNKNOWN }

class AppDimen {
  static const double itemMinHeight = 52.0;
  
  static const double itemHeaderTextSize = 18.0;
  static const double itemTitleTextSize = 12.0;
  static const double itemTextSize = 16.0;
  static const double itemDescTextSize = 13.0;
}

class AppColor {
  static final Color primaryColor = Colors.blue[600]!;
  static final Color primaryDarkColor = Colors.blue[600]!;
  static final Color accentColor = Colors.blue[600]!;

  static final listDelimiter = Colors.grey.withAlpha(70);
  static final border = Colors.blueGrey.withAlpha(70);
  static final dropDownUnderline = Colors.grey;

  static final howTo = Colors.grey[600]!;
  static final itemHeader = Colors.grey[700]!;
  static final itemBgHeader = Colors.grey[400]!;
  static final itemTitle = Colors.grey[600]!;
  static final itemDescription = Colors.grey[600]!;

  static final responseCardData = HexColor("#D7E4F3");
  static final responseProductMask = HexColor("#D7E4F3");
  static final responseSettingsMask = HexColor("#D7F3E6");
}
