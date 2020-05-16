import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class App {
  static const isDebug = !kReleaseMode;
  static DeviceMetrics metrics;
  static PlatformType platformType;

  static Stream<bool> streamShowDescription = BehaviorSubject<bool>()..add(true)..stream;

  static forceClose() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

class DeviceMetrics {
  static const double perfWidth = 360;
  static const double perfHeight = 640;

  // Tablets
  // ipad pro 12 1g			= aspectRatio = 1.33

  // Phones ios
  // iphone xr 					= aspectRatio = 2.16

  // Phones android
  // pixel 3						= aspectRatio = 1.877 deleted
  // pixel 3 xl					= aspectRatio = 1.938
  // pixel 3a xl				= aspectRatio = 1.938
  // pixel 2 xl				  = aspectRatio = 1.883
  // nexus 6  				  = aspectRatio = 1.661

  final double width;
  final double height;
  final double devicePixelRatio;
  final double aspectRatio;

  double get convertRatio => _convertRatio ?? _calculateConvertRatio(this);

  DeviceType get deviceType => _deviceType ?? _determineDeviceType(this);

  double _convertRatio;
  DeviceType _deviceType;

  DeviceMetrics({this.width, this.height, this.devicePixelRatio}) : aspectRatio = height / width;

  double widthChunk(double chunk) => width / chunk;

  double heightChunk(double chunk) => height / chunk;

  static double _calculateConvertRatio(DeviceMetrics metrics) {
    double convertRatio = (metrics.width / perfWidth + metrics.height / perfHeight) / 2;

    if (metrics.deviceType == DeviceType.WIDE) convertRatio -= 0.5;
    if (metrics.deviceType == DeviceType.THIN) convertRatio -= 0.1;
    if (metrics.deviceType == DeviceType.U_THIN) convertRatio -= 0.13;
    metrics._convertRatio = convertRatio;
    return metrics._convertRatio;
  }

  static DeviceType _determineDeviceType(DeviceMetrics metrics) {
    if (metrics.aspectRatio < 1.55) {
      metrics._deviceType = DeviceType.WIDE;
    } else if (metrics.aspectRatio < 1.8) {
      metrics._deviceType = DeviceType.N;
    } else if (metrics.aspectRatio < 2.0) {
      metrics._deviceType = DeviceType.THIN;
    } else
      metrics._deviceType = DeviceType.U_THIN;

    return metrics._deviceType;
  }
}

enum DeviceType { N, THIN, U_THIN, WIDE }

enum PlatformType { IOS, ANDROID, UNKNOWN }

class AppDimen {
  static const double toolbarHeight = 55;
  static const double toolbarBorderRadius = 16;

  static const itemBaseHeight = 55.0;
  static const itemTextSize = 16.0;
  static const itemDescTextSize = 12;

  // Если это виджет созданный внутри проекта, то функцию convert(double) использовать
  // внутри виджета для конвертации собственных, а не в входных параметрах. Для всех остальных
  // виджетов, включая системные конвертацию применять на этапе создания виджета
  static double convert(double input) => input * App.metrics.convertRatio;
}

class AppColor {
  static final Color primaryColor = Colors.blueGrey;
  static final Color primaryDarkColor = Colors.blueGrey[700];
  static final Color accentColor = Colors.blueGrey[700];

  static final textHintDescription = Colors.grey;
}

class AppDimenEdgeInsets extends EdgeInsets {
  AppDimenEdgeInsets.all(double value) : super.all(value == 0.0 ? value : AppDimen.convert(value));

  AppDimenEdgeInsets.fromLTRB(double left, double top, double right, double bottom)
      : super.fromLTRB(
          AppDimen.convert(left),
          AppDimen.convert(top),
          AppDimen.convert(right),
          AppDimen.convert(bottom),
        );

  AppDimenEdgeInsets.only({double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0})
      : super.only(
          left: left == 0.0 ? left : AppDimen.convert(left),
          top: top == 0.0 ? top : AppDimen.convert(top),
          right: right == 0.0 ? right : AppDimen.convert(right),
          bottom: bottom == 0.0 ? bottom : AppDimen.convert(bottom),
        );

  AppDimenEdgeInsets.symmetric({double vertical = 0.0, double horizontal = 0.0})
      : super.symmetric(
          vertical: vertical == 0.0 ? vertical : AppDimen.convert(vertical),
          horizontal: horizontal == 0.0 ? horizontal : AppDimen.convert(horizontal),
        );
}

class AppDimenSizedBox extends SizedBox {
  AppDimenSizedBox({Key key, double width, double height, Widget child})
      : super(
          key: key,
          width: width == null ? width : AppDimen.convert(width),
          height: height == null ? height : AppDimen.convert(height),
          child: child,
        );
}
