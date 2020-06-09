import 'package:devkit/app/ui/screen/card_action/depersonalization_screen.dart';
import 'package:devkit/app/ui/screen/card_action/personalization/personalization_screen.dart';
import 'package:devkit/app/ui/screen/card_action/scan_screen.dart';
import 'package:devkit/app/ui/screen/card_action/sign_screen.dart';
import 'package:devkit/app/ui/screen/main_screen.dart';
import 'package:devkit/app/ui/screen/response/response_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const MAIN = "/";
  static const SCAN = "/scan";
  static const SIGN = "/sign";
  static const PERSONALIZE = "/personalize";
  static const DEPERSONALIZE = "/depersonalize";
  static const RESPONSE = "/response";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case MAIN:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case SCAN:
        return MaterialPageRoute(builder: (_) => ScanScreen());
      case SIGN:
        return MaterialPageRoute(builder: (_) => SignScreen());
      case PERSONALIZE:
        return MaterialPageRoute(builder: (_) => PersonalizationScreen());
      case DEPERSONALIZE:
        return MaterialPageRoute(builder: (_) => DepersonalizationScreen());
      case RESPONSE:
        return PageRouteBuilder(pageBuilder: (_, _1, _2) => ResponseScreen(arguments: settings.arguments));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
