import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodzi/Login/LoginContractor.dart';
import 'package:foodzi/Models/loginmodel.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:foodzi/Utils/shared_preference.dart';

class LoginPresenter extends LoginContract {
  LoginModelView mLoginView;

  LoginPresenter(LoginModelView mView) {
    this.mLoginView = mView;
  }

  @override
  void onBackPresed() {}

  _encryptValue(String value) {
    return EncryptionAES.getData(value);
  }

  void performLogin(String mobno ,String countryCode, String password, BuildContext context) {
    ApiBaseHelper().post<LoginModel>(UrlConstant.loginApi, context, body: {
      JSON_STR_MOB_NO: mobno,
      "country_code":countryCode,
      JSON_STR_PWD: _encryptValue(password),
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          var userdata = json.encode(value.model);
          Preference.setPersistData<String>(userdata, PreferenceKeys.User_data);
          Globle().loginModel = value.model;
          Globle().authKey = value.model.token;
          mLoginView.loginSuccess();
          break;
        case SuccessType.failed:
          mLoginView.loginFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
