import 'package:flutter/material.dart';

abstract class OtpContract {
  void verifyotp(String mobno, BuildContext context);
  void onBackPresed();
}

abstract class OTPModelView {
  void otpsuccess();
  void otpfailed();
}
