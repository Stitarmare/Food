import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart' as crypto;

class PreferenceKeys {
  static const AUTH_KEY = "AUTH_KEY";
  static const User_data = 'USER_DATA';
  static final dineCartItemCount = "DINE_CART_ITEM_COUNT";
  static final takeAwayCartCount = "TAKE_AWAY_ITEM_COUNT";
  static final isAlreadyINCart = "IS_ALREADY_IN_CART";
  static final restaurantID = "RESTAURANT_ID";
  static final isAlreadyINCartTA = "IS_ALREADY_IN_CART_TA";
  static final restaurantIDTA = "RESTAURANT_ID_TA";
  static final restaurantName = "RESTAURANT_NAME";
  static final ORDER_ID = "ORDER_ID";
  static final CURRENT_ORDER_ID = "CURRENT_ORDER_ID";
  static final CURRENT_RESTAURANT_ID = "CURRENT_RESTAURANT_ID";
  static final ISDINEIN = "ISDINEIN";

  // static const Sign_UP_With_User_Data = 'Sign_In_With_User_Data';
  // static const Sign_IN_With_OTP = "Sign_IN_With_OTP";
  // static const ResetOtp = "ResetOtp";

}

class Preference {
  static setAuthKey(String value) async {
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(PreferenceKeys.AUTH_KEY, value);
    _sharedPreferences.commit();
  }

  static removeForKey(String key) async {
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();

    _sharedPreferences.remove(key);
  }

  static setPersistData<T>(T value, String key) async {
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();

    // _sharedPreferences.remove(key);

    if (T == String) {
      _sharedPreferences.setString(key, value as String);
    }
    if (T == int) {
      _sharedPreferences.setInt(key, value as int);
    }
    if (T == bool) {
      _sharedPreferences.setBool(key, value as bool);
    }
    if (T == double) {
      _sharedPreferences.setDouble(key, value as double);
    }
  }

  static Future<T> getPrefValue<T>(String key) async {
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();
    if (T == String) {
      return _sharedPreferences.getString(key) as T;
    }
    if (T == int) {
      return _sharedPreferences.getInt(key) as T;
    }
    if (T == bool) {
      return _sharedPreferences.getBool(key) as T;
    }
    if (T == double) {
      return _sharedPreferences.getDouble(key) as T;
    }
  }

  static removeAllPref() async {
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.clear();
  }
}

class EncryptionAES {
  static String getData(String value) {
    var bytes = utf8.encode(value);
    return crypto.md5.convert(bytes).toString();
  }
}
