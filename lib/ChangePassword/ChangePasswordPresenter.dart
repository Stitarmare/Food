import 'package:flutter/material.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:foodzi/ChangePassword/ChangePasswordContractor.dart';
import 'package:foodzi/Utils/shared_preference.dart';

class ChangePasswordPresenter extends ChangePasswordContractor {
  ChangePasswordModelView changePassView;

  ChangePasswordPresenter(ChangePasswordModelView mView) {
    this.changePassView = mView;
  }

  @override
  void onBackPresed() {}

  void performChangePassword(String oldPassowrd, String newPassword,
      String confirmPassword, BuildContext context) {
    ApiBaseHelper()
        .post<ErrorModel>(UrlConstant.changePassword, context, body: {
      JSON_STR_OLD_PWD: EncryptionAES.getData(oldPassowrd),
      JSON_STR_NEW_PWD: EncryptionAES.getData(newPassword),
      JSON_STR_PWD_CONFIRM: EncryptionAES.getData(confirmPassword),
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          changePassView.changePasswordsuccess();
          break;
        case SuccessType.failed:
          changePassView.changePasswordfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
