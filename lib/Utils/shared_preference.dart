import 'package:shared_preferences/shared_preferences.dart';

class PreferenceKeys {
  static final AUTH_KEY = "AUTH_KEY";
}
 

class Preference {
  static setAuthKey(String value) async {
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(PreferenceKeys.AUTH_KEY, value);
    _sharedPreferences.commit();
  }

  static Future<dynamic> getPrefValue<T>(String key) async {
     SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();
    if (T == String) {
      return _sharedPreferences.getString(key);
    }
    if (T == int) {
      return _sharedPreferences.getInt(key);
    }
    if (T == bool) {
      return _sharedPreferences.getBool(key);
    }
    if (T == double) {
      return _sharedPreferences.getDouble(key);
    }
  }
  static removeAllPref() async {
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.clear();
  }
}
