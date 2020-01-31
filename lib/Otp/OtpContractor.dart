import 'package:flutter/material.dart';

abstract class OtpContract {
  void resendOTP(String mobno, BuildContext context);
  void verifyotp(String mobno, BuildContext context);
  void perfromresetpassword(String mobno, String otp, BuildContext context);
  void performOTP(String mobno, String otp, BuildContext context);
  void onBackPresed();
}

abstract class OTPModelView {
  void otpsuccess();
  void otpfailed();
  void getSuccesForForgetPass();
  void getFailedForForgetPass();
  void loginwithotpsuccess();
  void loginwithotpfailed();
  void resendotpsuccess(String msg);
  void resendotpfailed();
}
