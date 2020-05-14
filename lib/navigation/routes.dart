import 'package:devkit/app/ui/screen/card_action/scan_screen.dart';
import 'package:devkit/app/ui/screen/card_action/sign_screen.dart';
import 'package:devkit/app/ui/screen/main_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const MAIN = "/";
  static const SCAN = "/scan";
  static const SIGN = "/sign";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case MAIN:
        return PageRouteBuilder(pageBuilder: (_, _1, _2) => MainScreen());
      case SCAN:
        return PageRouteBuilder(pageBuilder: (_, _1, _2) => ScanScreen());
      case SIGN:
        return PageRouteBuilder(pageBuilder: (_, _1, _2) => SignScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
