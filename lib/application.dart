import 'package:devkit/app/resources/keys.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/resources/localization.dart';
import 'commons/route_observer.dart';
import 'commons/utils/app_attributes.dart';
import 'navigation/routes.dart';

class DevKitApp extends StatefulWidget {
  DevKitApp() : super(key: ItemId.from(randomRange(0, 10000).toString()));

  @override
  _DevAppState createState() => _DevAppState();
}

class _DevAppState extends State<DevKitApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => ApplicationContext())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.get(),
        initialRoute: Routes.MAIN,
        localizationsDelegates: [AppLocalization.delegate],
        localeResolutionCallback: AppLocalization.resolutionCallback,
        onGenerateRoute: Routes.generateRoutes,
        navigatorObservers: AppNavigatorObservers.get(),
      ),
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

class ApplicationContext {
  final TestStorageRepository testStoreRepository = TestStorageRepository();
  late final TestRecorderBlock testRecorderBloc;

  ApplicationContext() {
    testRecorderBloc = TestRecorderBlock(testStoreRepository);
  }
}
