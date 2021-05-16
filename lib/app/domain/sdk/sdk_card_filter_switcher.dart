import 'package:devkit/commons/global/shared_preferences.dart';
import 'package:prefs/prefs.dart';

class TangemSdkCardFilterSwitcher {
  final _key = "allowsOnlyDebugCards";

  SharedPreferences _shPref = AppSharedPreferences.shPref;

  TangemSdkCardFilterSwitcher() {
    if (!_shPref.containsKey(_key)) _shPref.setBool(_key, true);
  }

  toggle() {
    _shPref.setBool(_key, !_isOn());
  }

  bool isAllowedOnlyDebugCards() => _isOn();

  bool _isOn() => _shPref.getBool(_key) ?? false;
}
