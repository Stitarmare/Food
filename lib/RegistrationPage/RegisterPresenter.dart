import 'package:flutter/material.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Models/registermodel.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';

import 'package:foodzi/network/url_constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/RegistrationPage/RegisterContractor.dart';
import 'package:foodzi/Utils/shared_preference.dart';

class RegisterPresenter extends RegisterContract {
  RegisterModelView mregisterView;

  RegisterPresenter(RegisterModelView mView) {
    this.mregisterView = mView;
  }

  @override
  void onBackPresed() {}

  @override
  _encryptValue(String value) {
    return EncryptionAES.getData(value);
  }

  void performregister(
      String first_name, String mobno, String password, BuildContext context) {
    var data = first_name.split(" ");
    var firstName = data[0];
    var lastName = data[1];
    ApiBaseHelper().post<ErrorModel>(UrlConstant.registerApi, context, body: {
      'first_name': firstName,
      'mobile_number': mobno,
      'password': _encryptValue(password),
      'device_token': "dsa",
      'device_type': "1",
      'user_type': "customer",
      'last_name': lastName
    }).then((value) {
      print(value);
       switch (value.result) {
        case SuccessType.success:
          print("Register success");
          print(value.model);
          mregisterView.registerSuccess();
          break;
        case SuccessType.failed:
          print("Register failed");
          mregisterView.registerfailed();
          break;
      }
      // if (value['status_code'] == 200) {
      //   mregisterView.registerSuccess();
      // } else {
      //   mregisterView.registerfailed(value['message']);
      // }
    }).catchError((error){
      print(error);
    });
//ApiCall
    //;
  }
}
