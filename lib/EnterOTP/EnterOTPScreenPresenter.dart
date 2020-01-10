

import 'package:flutter/material.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/url_constant.dart';

abstract class EnterOTPScreenPresenterView {
  void onRequestOtpSuccess(); 
  void onRequestOtpFailed();
}

class EnterOTPScreenPresenter {
  EnterOTPScreenPresenterView view;

  EnterOTPScreenPresenter({this.view});



  requestForOTP(String mobileNumber,BuildContext context) {
    ApiBaseHelper().post(UrlConstant.resetPasswordWithOTP, context,body: {
      "mobile_number":mobileNumber
    }).then((value){
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