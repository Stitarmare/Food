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
  void requestforUpdateNoOtpSuccess();
  void requestforUpdateNoOtpFailed();
}

class EnterOTPScreenPresenter extends EnterOtpContractor {
  EnterOTPModelView enterotpview;

  EnterOTPScreenPresenter(EnterOTPModelView mView) {
    this.enterotpview = mView;
  }

  requestforloginOTP(
      String mobileno, String countryCode, BuildContext context) {
    ApiBaseHelper().post<LoginWithOtpModel>(UrlConstant.loginwithOTP, context,
        body: {
          JSON_STR_MOB_NO: mobileno,
          "country_code": countryCode
        }).then((value) {
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

  requestForOTP(String mobileNumber, String countryCode, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.resetPasswordWithOTP, context,
        body: {
          JSON_STR_MOB_NO: mobileNumber,
          "country_code": countryCode
        }).then((value) {
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

  @override
  void requestforUpdateNoOtp(
      String mobno, String countryCode, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.sendOtpNewNo, context, body: {
      JSON_STR_MOB_NO: mobno,
      "country_code": countryCode
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          enterotpview.requestforUpdateNoOtpSuccess();
          break;
        case SuccessType.failed:
          enterotpview.requestforUpdateNoOtpFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  provideAnotherNumberOTP(String oldNumber, String newMobileno,
      String countryCode, String oldCountryCode, BuildContext context) {
    ApiBaseHelper()
        .post<ErrorModel>(UrlConstant.provideAnotherNumberApi, context, body: {
      "old_mobile_number": oldNumber,
      "new_mobile_number": newMobileno,
      "new_mobile_number_country_code": countryCode,
      "old_mobile_number_country_code": oldCountryCode,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          enterotpview.onProvideOtpSuccess();
          break;
        case SuccessType.failed:
          enterotpview.onProvideOtpFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
