import 'package:flutter/material.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';

import 'package:foodzi/network/url_constant.dart';
//import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/ResetPassword/ResetpassContractor.dart';
import 'package:foodzi/Utils/shared_preference.dart';

class ResetpasswordPresenter extends ResetpassContractor {
  ResetPassModelView mregisterView;

  ResetpasswordPresenter(ResetPassModelView mView) {
    this.mregisterView = mView;
  }

  @override
  void onBackPresed() {}

  void perfromresetpassword(
      String mobno, String password, BuildContext context) {
    ApiBaseHelper().post(UrlConstant.updatePassword, context, body: {
      'mobile_number': mobno,
      'password': EncryptionAES.getData(password),
      'password_confirmation': EncryptionAES.getData(password)
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("success");
          //print(value.model);
          //Globle().loginModel = value.model;
          //Globle().authKey = value.model.token;
           mregisterView.resetpasssuccess();
          break;
        case SuccessType.failed:
          print("failed");
         mregisterView.resetpassfailed();
          break;
      }
      // if (value['status_code'] == 200) {
      //   mregisterView.resetpasssuccess();
      // } else {
      //   mregisterView.resetpassfailed();
      // }
    });
//ApiCall
    //;
  }
}
