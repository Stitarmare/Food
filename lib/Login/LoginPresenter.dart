import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodzi/Login/LoginContractor.dart';
import 'package:foodzi/Models/loginmodel.dart';
import 'package:foodzi/Utils/globle.dart';

import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

//import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPresenter extends LoginContract {
  LoginModelView mLoginView;

  LoginPresenter(LoginModelView mView) {
    this.mLoginView = mView;
  }

  @override
  void onBackPresed() {}

  @override
  _encryptValue(String value) {
    return EncryptionAES.getData(value);
  }

  void performLogin(String mobno, String password, BuildContext context) {
    ApiBaseHelper().post<LoginModel>(UrlConstant.loginApi, context, body: {
      'mobile_number': mobno,
      'password': _encryptValue(password),
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Login success");
          print(value.model);
          //var loginmodel = LoginModel.fromJson(value);
          var userdata = json.encode(value.model);
          Preference.setPersistData<String>(userdata, PreferenceKeys.User_data);
          Globle().loginModel = value.model;
          Globle().authKey = value.model.token;
          mLoginView.loginSuccess();
          break;
        case SuccessType.failed:
          print("failed");
          mLoginView.loginFailed();
          break;
      }
      // if (value['status_code'] == 200) {
      //   var loginModel = LoginModel.fromJson(value);

      //   Globle().loginModel = loginModel;
      //   Globle().authKey = loginModel.token;
      //   mLoginView.loginSuccess();
      // } else {
      //   mLoginView.loginFailed(value['message']);
      // }
    }).catchError((error) {
      print(error);
    });
//ApiCall
    //;
  }
}
