import 'dart:async';

import 'package:devkit/commons/global/show_description.dart';
import 'package:devkit/commons/global/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tangem_sdk/sdk_plugin.dart';

import 'app/domain/sdk/sdk_card_filter_switcher.dart';
import 'application.dart';
import 'commons/utils/app_attributes.dart';
import 'commons/utils/logger.dart';

class AppLauncher {
  // launches before runApp()
  launch() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColor.primaryDarkColor));
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await AppSharedPreferences.init();

    Logger.instance.logAction(this, "launch");
    DescriptionState.init(false);
  }

  _launchApplication(AppLauncher initializer) {
    final isAllowedOnlyDebug = TangemSdkCardFilterSwitcher().isAllowedOnlyDebugCards();
    TangemSdk.allowsOnlyDebugCards(isAllowedOnlyDebug);
    runApp(DevKitApp());
  }
}

class DebugLauncher extends AppLauncher {
  @override
  launch() async {
    await super.launch();
//    FirebaseAnalytics().setAnalyticsCollectionEnabled(false);
    _launchApplication(this);
  }
}

class ReleaseLauncher extends AppLauncher {
  @override
  launch() async {
    await super.launch();
//    FirebaseAnalytics().setAnalyticsCollectionEnabled(true);
    await _initCrashlytics();
  }

  _initCrashlytics() async {
//    await FlutterCrashlytics().initialize();
    FlutterError.onError = (FlutterErrorDetails details) => Zone.current.handleUncaughtError(details.exception, details.stack);

//    runZoned<Future<Null>>(() async {
    _launchApplication(this);
//    }, onError: (error, stackTrace) async {
//      await FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: true);
//    });
  }
}
