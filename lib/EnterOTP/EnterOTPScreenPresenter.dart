import 'package:flutter/material.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/url_constant.dart';

abstract class EnterOTPScreenPresenterView {
  void onRequestOtpSuccess();
  void onRequestOtpFailed();
  void requestforloginotpsuccess();
  void requestforloginotpfailed();
}

class EnterOTPScreenPresenter {
  EnterOTPScreenPresenterView view;

  EnterOTPScreenPresenter({this.view});

  requestforloginOTP(String mobileno, BuildContext context) {
    ApiBaseHelper().post(UrlConstant.loginwithOTP, context,
        body: {"mobile_number": mobileno}).then((value) {
      print(value);
      if (value['status_code'] == 200) {
        view.requestforloginotpsuccess();
      } else {
        view.requestforloginotpfailed();
      }
    }).catchError((error) {
      view.requestforloginotpfailed();
    });
  }

  requestForOTP(String mobileNumber, BuildContext context) {
    ApiBaseHelper().post(UrlConstant.resetPasswordWithOTP, context,
        body: {"mobile_number": mobileNumber}).then((value) {
      print(value);
      if (value['status_code'] == 200) {
        view.onRequestOtpSuccess();
      } else {
        view.onRequestOtpFailed();
      }
    }).catchError((error) {
      view.onRequestOtpFailed();
    });
  }
}
