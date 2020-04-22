import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';
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
      String mobno,String countryCode, String password, BuildContext context) {
    ApiBaseHelper().post(UrlConstant.updatePassword, context, body: {
      JSON_STR_MOB_NO: mobno,
      "country_code":countryCode,
      JSON_STR_PASSWORD: EncryptionAES.getData(password),
      JSON_STR_PWD_CONFIRMATION: EncryptionAES.getData(password)
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          mregisterView.resetpasssuccess();
          break;
        case SuccessType.failed:
          mregisterView.resetpassfailed();
          break;
      }
    });
  }
}
