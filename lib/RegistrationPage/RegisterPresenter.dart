import 'package:flutter/material.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:foodzi/RegistrationPage/RegisterContractor.dart';
import 'package:foodzi/Utils/shared_preference.dart';

class RegisterPresenter extends RegisterContract {
  RegisterModelView mregisterView;

  RegisterPresenter(RegisterModelView mView) {
    this.mregisterView = mView;
  }

  @override
  void onBackPresed() {}

  _encryptValue(String value) {
    return EncryptionAES.getData(value);
  }

  void performregister(String firstName, String lastname, String mobno,
      String password,String countryCode, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.registerApi, context, body: {
      JSON_STR_FIRSTNAME: firstName,
      JSON_STR_LASTNAME: lastname,
      JSON_STR_MOB_NO: mobno,
      JSON_STR_PASSWORD: _encryptValue(password),
      JSON_STR_DEVICE_TYPE: STR_ONE,
      JSON_STR_USER_TYPE: STR_CUSTOMER,
      "country_code":countryCode
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          mregisterView.registerSuccess();
          break;
        case SuccessType.failed:
          mregisterView.registerfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
