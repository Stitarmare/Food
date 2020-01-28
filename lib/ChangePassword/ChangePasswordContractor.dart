import 'package:flutter/material.dart';

abstract class ChangePasswordContractor {
  void performChangePassword(String oldPassowrd,String newPassword,String confirmPassword, BuildContext context);
  void onBackPresed();
}

abstract class ChangePasswordModelView {
  void changePasswordsuccess();
  void changePasswordfailed();
}