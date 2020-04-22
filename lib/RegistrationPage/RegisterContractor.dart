import 'package:flutter/material.dart';

abstract class RegisterContract {
  void performregister(String firstName, String lastName, String mobno,
      String password,String countryCode, BuildContext context);
  void onBackPresed();
}

abstract class RegisterModelView {
  void registerSuccess();
  void registerfailed();
}
