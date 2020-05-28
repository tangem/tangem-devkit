import 'package:prefs/prefs.dart';

class AppSharedPreferences {
  static SharedPreferences _shPref;

  static SharedPreferences get shPref => _shPref;

  static init() async {
    _shPref = await SharedPreferences.getInstance();
  }
}
