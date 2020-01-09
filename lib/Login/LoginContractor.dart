import 'package:flutter/material.dart';

abstract class LoginContract {
  void performLogin(String mobno, String password, BuildContext context);
  void onBackPresed();
}

abstract class LoginModelView {
  void loginSuccess();
  void loginFailed();
}
