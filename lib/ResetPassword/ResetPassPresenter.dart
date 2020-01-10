import 'package:flutter/material.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';

import 'package:foodzi/network/url_constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/ResetPassword/ResetpassContractor.dart';
import 'package:foodzi/Utils/shared_preference.dart';

class ResetpasswordPresenter extends ResetpassContractor {
  ResetPassModelView mregisterView;

  ResetpasswordPresenter(ResetPassModelView mView) {
    this.mregisterView = mView;
  }

  @override
  void onBackPresed() {}

  void perfromresetpassword(String mobno, BuildContext context) {
    ApiBaseHelper().post(UrlConstant.resetpassverifyotp, context, body: {
      'mobile_number': mobno,
      'device_token': "dsa",
      'device_type': "1",
      'user_type': "customer",
      'otp': '123456',
    }).then((value) {
      print(value);
      if (value['status_code'] == 200) {
        mregisterView.resetpasssuccess();
      }
    });
//ApiCall
    //;
  }
}
