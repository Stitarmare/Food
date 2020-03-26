import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodzi/EnterMobileNoOTP/EnterOtpContractor.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Models/loginwithotp.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/shared_preference.dart';
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
  EnterOTPModelView enterotpview;

  EnterOTPScreenPresenter(EnterOTPModelView mView) {
    this.enterotpview = mView;
  }

  requestforloginOTP(String mobileno, BuildContext context) {
    ApiBaseHelper().post<LoginWithOtpModel>(UrlConstant.loginwithOTP, context,
        body: {JSON_STR_MOB_NO: mobileno}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          var userloginotp = json.encode(value.model);
          Preference.setPersistData(userloginotp, PreferenceKeys.User_data);
          enterotpview.onRequestOtpSuccess();
          break;
        case SuccessType.failed:
          enterotpview.onRequestOtpFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void onBackPresed() {}

  requestForOTP(String mobileNumber, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.resetPasswordWithOTP, context,
        body: {JSON_STR_MOB_NO: mobileNumber}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          enterotpview.requestforloginotpsuccess();
          break;
        case SuccessType.failed:
          enterotpview.requestforloginotpfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
