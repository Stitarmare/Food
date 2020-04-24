import 'package:flutter/material.dart';

abstract class OtpContract {
  void resendOTP(String mobno, String countryCode, BuildContext context);
  void verifyotp(String mobno, String countryCode, BuildContext context);
  void perfromresetpassword(
      String mobno, String countryCode, String otp, BuildContext context);
  void performOTP(
      String mobno, String countryCode, String otp, BuildContext context);
  void performOTPUpdateNo(
      String mobno, String countryCode, String otp, BuildContext context);

  void onBackPresed();
}

abstract class OTPModelView {
  void otpsuccess();
  void otpfailed();
  void getSuccesForForgetPass();
  void getFailedForForgetPass();
  void performOTPUpdateNoSuccess();
  void performOTPUpdateNoFailed();
  void loginwithotpsuccess();
  void loginwithotpfailed();
  void resendotpsuccess(String msg);
  void resendotpfailed();
}
