import 'package:flutter/material.dart';

abstract class RegisterContract {
  void performregister(
      String first_name, String mobno, String password, BuildContext context);
  void onBackPresed();
}

abstract class RegisterModelView {
  void registerSuccess();
  void registerfailed();
}
