import 'package:flutter/material.dart';
import 'package:foodzi/Models/error_model.dart';

abstract class LoginContract {
  void performLogin(
      String mobno, String countryCode, String password, BuildContext context);
  void onBackPresed();
}

abstract class LoginModelView {
  void loginSuccess();
  void loginFailed();
}
