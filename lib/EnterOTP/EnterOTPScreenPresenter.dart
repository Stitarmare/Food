import 'package:flutter/material.dart';
import 'package:foodzi/EnterOTP/EnterOtpContractor.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Models/loginwithotp.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

abstract class EnterOTPScreenPresenterView {
  void onRequestOtpSuccess();
  void onRequestOtpFailed();
  void requestforloginotpsuccess();
  void requestforloginotpfailed();
}

class EnterOTPScreenPresenter extends EnterOtpContractor {
  //EnterOTPScreenPresenter({this.view});

  EnterOTPModelView enterotpview;

  EnterOTPScreenPresenter(EnterOTPModelView mView) {
    this.enterotpview = mView;
  }

  requestforloginOTP(String mobileno, BuildContext context) {
    ApiBaseHelper().post<LoginWithOtpModel>(UrlConstant.loginwithOTP, context,
        body: {"mobile_number": mobileno}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Success");
          print(value.model);
          enterotpview.onRequestOtpSuccess();
          break;
        case SuccessType.failed:
          print("Failed");
          enterotpview.onRequestOtpFailed();
          break;
      }
      // if (value['status_code'] == 200) {
      //   view.requestforloginotpsuccess();
      // } else {
      //   view.requestforloginotpfailed();
      // }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void onBackPresed() {}

  requestForOTP(String mobileNumber, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.resetPasswordWithOTP, context,
        body: {"mobile_number": mobileNumber}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Success");
          print(value.model);
          enterotpview.requestforloginotpsuccess();
          break;
        case SuccessType.failed:
          print("Failed");
          enterotpview.requestforloginotpfailed();
          break;
      }
      // if (value['status_code'] == 200) {
      //   view.onRequestOtpSuccess();
      // } else {
      //   view.onRequestOtpFailed();
      // }
    }).catchError((error) {
      print(error);
      // view.onRequestOtpFailed();
    });
  }
}
