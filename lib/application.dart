import 'package:flutter/material.dart';

import 'commons/route_observer.dart';
import 'commons/utils/app_attributes.dart';
import 'navigation/routes.dart';

class DevKitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.def(),
      initialRoute: Routes.MAIN,
      onGenerateRoute: Routes.generateRoutes,
      navigatorObservers: AppNavigatorObservers.def(),
    );
  }
}

class AppTheme {
  static def() => ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColor.primaryColor,
        accentColor: AppColor.accentColor,
      );
}

class AppNavigatorObservers {
  static def() => [AnalyticsRouteObserver()];
}
