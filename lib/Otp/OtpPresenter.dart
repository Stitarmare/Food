import 'package:flutter/material.dart';
import 'package:foodzi/Models/Modelclass.dart';
import 'package:foodzi/Otp/OtpContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
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

  void performOTP(String mobno, String otp, BuildContext context) {
    ApiBaseHelper().post(UrlConstant.verifyotp, context, body: {
      'otp': otp,
      'device_token': 'gfgfg',
      'user_type': 'customer',
      'device_type': '1',
      'mobile_number': mobno,
    }).then((value) {
      print(value);
      if (value['status_code'] == 200) {
        otpView.otpsuccess();
      }
    });
//ApiCall
    //;
  }

  @override
  void verifyotp(String mobno, BuildContext context) {
    // TODO: implement verifyotp
  }
}
