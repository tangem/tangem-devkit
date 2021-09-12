import 'package:devkit/app/ui/screen/card_action/depersonalization_screen.dart';
import 'package:devkit/app/ui/screen/card_action/files_change_settings_screen.dart';
import 'package:devkit/app/ui/screen/card_action/files_delete_screen.dart';
import 'package:devkit/app/ui/screen/card_action/files_read_screen.dart';
import 'package:devkit/app/ui/screen/card_action/files_write_screen.dart';
import 'package:devkit/app/ui/screen/card_action/issuer_read_data_screen.dart';
import 'package:devkit/app/ui/screen/card_action/issuer_read_ex_data_screen.dart';
import 'package:devkit/app/ui/screen/card_action/issuer_write_data_screen.dart';
import 'package:devkit/app/ui/screen/card_action/issuer_write_ex_data_screen.dart';
import 'package:devkit/app/ui/screen/card_action/personalization/personalization_screen.dart';
import 'package:devkit/app/ui/screen/card_action/scan_screen.dart';
import 'package:devkit/app/ui/screen/card_action/set_pin_screen.dart';
import 'package:devkit/app/ui/screen/card_action/sign_screen.dart';
import 'package:devkit/app/ui/screen/card_action/test_screen.dart';
import 'package:devkit/app/ui/screen/card_action/user_read_data_screen.dart';
import 'package:devkit/app/ui/screen/card_action/user_write_data_screen.dart';
import 'package:devkit/app/ui/screen/card_action/user_write_protected_data_screen.dart';
import 'package:devkit/app/ui/screen/card_action/wallet_create_screen.dart';
import 'package:devkit/app/ui/screen/card_action/wallet_purge_screen.dart';
import 'package:devkit/app/ui/screen/main_screen.dart';
import 'package:devkit/app/ui/screen/response/response_screen.dart';
import 'package:devkit/app_test_assembler/ui/screen/json_test_detail_screen.dart';
import 'package:devkit/app_test_assembler/ui/screen/json_test_list_screen.dart';
import 'package:devkit/app_test_assembler/ui/screen/test_setup_detail_screen.dart';
import 'package:devkit/app_test_assembler/ui/screen/test_step_detail_screen.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tangem_sdk/model/sdk.dart';

class Routes {
  static const MAIN = "/";
  static const TEST = "/test";
  static const JSON_TEST_LIST = "/json_test_list";
  static const JSON_TEST_DETAIL = "/json_test_detail";
  static const TEST_SETUP_DETAIL = "/test_setup_detail";
  static const TEST_STEP_DETAIL = "/test_step_detail";
  static const SCAN = "/scan";
  static const SIGN = "/sign";
  static const PERSONALIZE = "/personalize";
  static const PERSONALIZE_PRESETS = "/personalize/presets";
  static const PERSONALIZE_PRESETS_DETAIL = "/personalize/presets/detail";
  static const DEPERSONALIZE = "/depersonalize";
  static const CREATE_WALLET = "/create_wallet";
  static const PURGE_WALLET = "/purge_wallet";
  static const ISSUER_READ_DATA = "/issuer_read_data";
  static const ISSUER_WRITE_DATA = "/issuer_write_data";
  static const ISSUER_READ_EX_DATA = "/issuer_read_ex_data";
  static const ISSUER_WRITE_EX_DATA = "/issuer_write_ex_data";
  static const USER_READ_DATA = "/user_read_data";
  static const USER_WRITE_DATA = "/user_write_data";
  static const USER_WRITE_PROTECTED_DATA = "/user_write_protected_data";
  static const SET_PIN1 = "/set_pin_1";
  static const SET_PIN2 = "/set_pin_2";
  static const FILES_READ = "/files_read";
  static const FILES_WRITE = "/files_write";
  static const FILES_DELETE = "/files_delete";
  static const FILES_CHANGE_SETTINGS = "/files_change_settings";
  static const RESPONSE = "/response";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case MAIN:
        return SlideRightRoute((_) => MainScreen(), settings);
      case SCAN:
        return SlideRightRoute((_) => ScanScreen(), settings);
      case SIGN:
        return SlideRightRoute((_) => SignScreen(), settings);
      case PERSONALIZE:
        return SlideRightRoute((_) => PersonalizationScreen(), settings);
      case DEPERSONALIZE:
        return SlideRightRoute((_) => DepersonalizationScreen(), settings);
      case CREATE_WALLET:
        return SlideRightRoute((_) => CreateWalletScreen(), settings);
      case PURGE_WALLET:
        return SlideRightRoute((_) => PurgeWalletScreen(), settings);
      case ISSUER_READ_DATA:
        return SlideRightRoute((_) => ReadIssuerDataScreen(), settings);
      case ISSUER_WRITE_DATA:
        return SlideRightRoute((_) => WriteIssuerDataScreen(), settings);
      case ISSUER_READ_EX_DATA:
        return SlideRightRoute((_) => ReadIssuerExDataScreen(), settings);
      case ISSUER_WRITE_EX_DATA:
        return SlideRightRoute((_) => WriteIssuerExDataScreen(), settings);
      case USER_READ_DATA:
        return SlideRightRoute((_) => ReadUserDataScreen(), settings);
      case USER_WRITE_DATA:
        return SlideRightRoute((_) => WriteUserDataScreen(), settings);
      case USER_WRITE_PROTECTED_DATA:
        return SlideRightRoute((_) => WriteUserProtectedDataScreen(), settings);
      case SET_PIN1:
        return SlideRightRoute((_) => SetPinScreen(PinType.PIN1), settings);
      case SET_PIN2:
        return SlideRightRoute((_) => SetPinScreen(PinType.PIN2), settings);
      case FILES_READ:
        return SlideRightRoute((_) => FilesReadScreen(), settings);
      case FILES_WRITE:
        return SlideRightRoute((_) => FilesWriteScreen(), settings);
      case FILES_DELETE:
        return SlideRightRoute((_) => FilesDeleteScreen(), settings);
      case FILES_CHANGE_SETTINGS:
        return SlideRightRoute((_) => FilesChangeSettingsScreen(), settings);
      case RESPONSE:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => ResponseScreen(arguments: settings.arguments));

      // others
      case TEST:
        return SlideRightRoute((_) => TestScreen(), settings);
      case JSON_TEST_LIST:
        return SlideRightRoute((_) => JsonTestListScreen(), settings);
      case JSON_TEST_DETAIL:
        return SlideRightRoute((_) => JsonTestDetailScreen(), settings);
      case TEST_SETUP_DETAIL:
        return SlideRightRoute((_) => TestSetupDetailScreen(), settings);
      case TEST_STEP_DETAIL:
        return SlideRightRoute((_) => TestStepDetailScreen(), settings);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

typedef ArgumentMap = Map<String, dynamic>;

ArgumentMap createArguments([String? key, dynamic value]) {
  final map = <String, dynamic>{};
  if (key != null) map[key] = value;
  return map;
}

extension AddArgument on ArgumentMap {
  ArgumentMap addArgument(String key, dynamic value) {
    return this..[key] = value;
  }
}

extension BuildContextReadArgument on BuildContext {
  dynamic readArgument<T>(String key) {
    final args = ModalRoute.of(this)?.settings?.arguments;
    if (args == null || args is! Map<String, dynamic>) {
      logE(this, "Can't read argument [$key]");
      return null;
    }

    return args[key] as T;
  }
}

extension RouteSettingsReadArgument on RouteSettings {
  dynamic readArgument<T>(String key) {
    if (this.arguments == null || this.arguments is! Map<String, dynamic>) return null;
    return (this.arguments as Map<String, dynamic>)[key] as T;
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final WidgetBuilder builder;

  SlideRightRoute(this.builder, [RouteSettings? settings])
      : super(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
