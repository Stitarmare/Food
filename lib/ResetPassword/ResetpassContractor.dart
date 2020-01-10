import 'package:flutter/material.dart';

abstract class ResetpassContractor {
  void perfromresetpassword(String mobno, BuildContext context);
  void onBackPresed();
}

abstract class ResetPassModelView {
  void resetpasssuccess();
  void resetpassfailed();
}
