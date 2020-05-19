import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/material.dart';

class AnalyticsRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _handleScreenChanges(route);
    }
  }

  @override
  didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _handleScreenChanges(newRoute);
    }
  }

  @override
  didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _handleScreenChanges(previousRoute);
    }
  }

  _handleScreenChanges(PageRoute<dynamic> route) {
    final String screenName = route.settings.name;
    if (screenName != null) {
      logRoute(this, screenName);
    }
  }
}
