import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Models/loginmodel.dart';
import 'package:foodzi/Otp/OtpContractor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';

class OtpPresenter extends OtpContract {
  OTPModelView otpView;

  OtpPresenter(OTPModelView mView) {
    this.otpView = mView;
  }

  @override
  void onBackPresed() {}

  void perfromresetpassword(String mobno,String countryCode, String otp, BuildContext context) {
    ApiBaseHelper()
        .post<ErrorModel>(UrlConstant.resetpassverifyotp, context, body: {
      JSON_STR_MOB_NO: mobno,
      "country_code":countryCode,
      JSON_STR_DEVICE_TOKEN: STR_DSA,
      JSON_STR_DEVICE_TYPE: STR_ONE,
      JSON_STR_USER_TYPE: STR_CUSTOMER,
      JSON_STR_OTP: otp,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);

          otpView.getSuccesForForgetPass();
          break;
        case SuccessType.failed:
          otpView.getFailedForForgetPass();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  void performOTP(String mobno,String countryCode, String otp, BuildContext context) {
    ApiBaseHelper().post<LoginModel>(UrlConstant.verifyotp, context, body: {
      JSON_STR_OTP: otp,
      JSON_STR_DEVICE_TOKEN: STR_RANDOM,
      JSON_STR_USER_TYPE: STR_CUSTOMER,
      JSON_STR_DEVICE_TYPE: STR_ONE,
      JSON_STR_MOB_NO: mobno,
      "country_code":countryCode,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          var userOtpdata = json.encode(value.model);
          Preference.setPersistData<String>(
              userOtpdata, PreferenceKeys.User_data);
          Globle().loginModel = value.model;
          Globle().authKey = value.model.token;
          otpView.otpsuccess();
          break;
        case SuccessType.failed:
          otpView.otpfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  void performresendOTP(String mobno,String countryCode, String otp, BuildContext context) {
    ApiBaseHelper().post(UrlConstant.verifyotp, context, body: {
      JSON_STR_MOB_NO: mobno,
      "country_code":countryCode,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          otpView.otpsuccess();
          break;
        case SuccessType.failed:
          otpView.otpfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void verifyotp(String mobno,String countryCode, BuildContext context) {}

  void resendOTP(String mobno,String countryCode, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.resendOTP, context, body: {
      JSON_STR_MOB_NO: mobno,
      "country_code":countryCode,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          var message = value.model.message;
          otpView.resendotpsuccess(message);
          break;
        case SuccessType.failed:
          otpView.resendotpfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
