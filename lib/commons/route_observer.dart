import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/material.dart';
import 'package:tangem_sdk/extensions/exp_extensions.dart';

class AnalyticsRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _handleScreenChanges(route);
    }
  }

  @override
  didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _handleScreenChanges(newRoute);
    }
  }

  @override
  didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _handleScreenChanges(previousRoute);
    }
  }

  _handleScreenChanges(PageRoute<dynamic> route) {
    route.settings.name?.let((it) => logRoute(this, it));
  }
}
