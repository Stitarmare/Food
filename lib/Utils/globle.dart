import 'dart:async';

import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/fcm_model.dart';
import 'package:foodzi/Models/loginmodel.dart';
import 'package:foodzi/Utils/String.dart';

class Globle {
  static final Globle _globle = Globle.internal();

  factory Globle() {
    return _globle;
  }

  Globle.internal();
  LoginModel loginModel;
  MenuCartDisplayModel menuCartDisplayModel;
  String fcmToken = "";
  StreamController<FcmModel> streamController = StreamController<FcmModel>.broadcast();
  bool notificationFLag = false;
  String colorscode;
  int dinecartValue = 0;
  int takeAwayCartItemCount = 0;
  String restauranrtName = STR_BLANK;
  String orderNumber = STR_BLANK;
  String currencySymb = STR_BLANK;
  var authKey;
  int orderID = 0;
}
