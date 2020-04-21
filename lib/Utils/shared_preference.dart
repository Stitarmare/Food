import 'dart:convert';
import 'package:foodzi/Utils/String.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart' as crypto;

class PreferenceKeys {
  static const AUTH_KEY = STR_AUTH_KEY;
  static const User_data = STR_USER_DATA;
  static final dineCartItemCount = STR_CART_ITEM_COUNT;
  static final takeAwayCartCount = STR_TAKE_AWAY_ITEM_COUNT;
  static final isAlreadyINCart = STR_IS_ALREADY_IN_CART;
  static final restaurantID = STR_RESTAURANT_ID;
  static final isAlreadyINCartTA = STR_IS_ALREADY_IN_CART_TA;
  static final restaurantIDTA = STR_RESTAURANT_ID_TA;
  static final restaurantName = STR_RETAURANT_NAME;
  static final orderId = STR_ORDER_ID;
  static final currentOrderId = STR_CURRENT_ORDER_ID;
  static final currentRestaurantId = STR_CURRENT_REST_ID;
  static final isDineIn = STR_IS_DINE_IN;
  static final tableId = STR_TABLE_ID;
}

class Preference {
  static setAuthKey(String value) async {
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(PreferenceKeys.AUTH_KEY, value);
  }

  static removeForKey(String key) async {
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();

    _sharedPreferences.remove(key);
  }

  static setPersistData<T>(T value, String key) async {
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();

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
