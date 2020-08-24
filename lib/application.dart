import 'package:devkit/app/resources/keys.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/material.dart';

import 'app/resources/localization.dart';
import 'commons/route_observer.dart';
import 'commons/utils/app_attributes.dart';
import 'navigation/routes.dart';

class DevKitApp extends StatelessWidget {
  DevKitApp(): super(key:ItemId.from(randomRange(0, 10000).toString()));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.get(),
      initialRoute: Routes.MAIN,
      localizationsDelegates: [AppLocalization.delegate],
      localeResolutionCallback: AppLocalization.resolutionCallback,
      onGenerateRoute: Routes.generateRoutes,
      navigatorObservers: AppNavigatorObservers.get(),
    );
  }
}

class AppTheme {
  static get() => ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColor.primaryColor,
        accentColor: AppColor.accentColor,
      );
}

class AppNavigatorObservers {
  static get() => List<NavigatorObserver>.from([AnalyticsRouteObserver()]);
}
