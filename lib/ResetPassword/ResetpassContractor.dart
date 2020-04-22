import 'package:flutter/material.dart';

abstract class ResetpassContractor {
  void perfromresetpassword(String mobno,String countryCode,String password, BuildContext context);
  void onBackPresed();
}

abstract class ResetPassModelView {
  void resetpasssuccess();
  void resetpassfailed();
}
