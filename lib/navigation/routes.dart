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
        return MaterialPageRoute(builder: (_) => MainScreen());
      case SCAN:
        return MaterialPageRoute(builder: (_) => ScanScreen());
      case SIGN:
        return MaterialPageRoute(builder: (_) => SignScreen());
      case PERSONALIZE:
        return MaterialPageRoute(builder: (_) => PersonalizationScreen());
      case DEPERSONALIZE:
        return MaterialPageRoute(builder: (_) => DepersonalizationScreen());
      case CREATE_WALLET:
        return MaterialPageRoute(builder: (_) => CreateWalletScreen());
      case PURGE_WALLET:
        return MaterialPageRoute(builder: (_) => PurgeWalletScreen());
      case ISSUER_READ_DATA:
        return MaterialPageRoute(builder: (_) => ReadIssuerDataScreen());
      case ISSUER_WRITE_DATA:
        return MaterialPageRoute(builder: (_) => WriteIssuerDataScreen());
      case ISSUER_READ_EX_DATA:
        return MaterialPageRoute(builder: (_) => ReadIssuerExDataScreen());
      case ISSUER_WRITE_EX_DATA:
        return MaterialPageRoute(builder: (_) => WriteIssuerExDataScreen());
      case USER_READ_DATA:
        return MaterialPageRoute(builder: (_) => ReadUserDataScreen());
      case USER_WRITE_DATA:
        return MaterialPageRoute(builder: (_) => WriteUserDataScreen());
      case USER_WRITE_PROTECTED_DATA:
        return MaterialPageRoute(builder: (_) => WriteUserProtectedDataScreen());
      case SET_PIN1:
        return MaterialPageRoute(builder: (_) => SetPinScreen(PinType.ACCESS_CODE));
      case SET_PIN2:
        return MaterialPageRoute(builder: (_) => SetPinScreen(PinType.PASSCODE));
      case FILES_READ:
        return MaterialPageRoute(builder: (_) => FilesReadScreen());
      case FILES_WRITE:
        return MaterialPageRoute(builder: (_) => FilesWriteScreen());
      case FILES_DELETE:
        return MaterialPageRoute(builder: (_) => FilesDeleteScreen());
      case FILES_CHANGE_SETTINGS:
        return MaterialPageRoute(builder: (_) => FilesChangeSettingsScreen());
      case RESPONSE:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => ResponseScreen(arguments: settings.arguments));
      case TEST:
        return MaterialPageRoute(builder: (_) => TestScreen());
      case JSON_TEST_LIST:
        return MaterialPageRoute(builder: (_) => JsonTestListScreen());
      case JSON_TEST_DETAIL:
        return CupertinoPageRoute(
          builder: (_) => JsonTestDetailScreen(),
          settings: settings,
        );
      case TEST_SETUP_DETAIL:
        return CupertinoPageRoute(
          builder: (_) => TestSetupDetailScreen(),
          settings: settings,
        );
      case TEST_STEP_DETAIL:
        return CupertinoPageRoute(
          builder: (_) => TestStepDetailScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
