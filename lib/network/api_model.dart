import 'package:flutter/foundation.dart';
import 'package:foodzi/Models/Otpverify.dart';
import 'package:foodzi/Models/Resendotp.dart';
import 'package:foodzi/Models/loginmodel.dart';
import 'package:foodzi/Models/registermodel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Models/loginwithotp.dart';

import 'package:foodzi/Models/authmodel.dart';
import 'package:foodzi/Models/resetpwdwithotp.dart';

enum SuccessType { success, failed }

class APIModel<T> {
  var result = SuccessType.failed;
  T model;
}

class GenericModel<T> {
  static T fromJson<T>(dynamic json) {
    switch (T) {
      case LoginModel:
        return LoginModel.fromJson(json) as T;

      case Registermodel:
        return Registermodel.fromJson(json) as T;

      case LoginWithOtpModel:
        return LoginWithOtpModel.fromJson(json) as T;

      case OtpVerifyModel:
        return OtpVerifyModel.fromJson(json) as T;

      case ResetpwdOtpModel:
        return ResetpwdOtpModel.fromJson(json) as T;

      case ResendOtpModel:
        return ResendOtpModel.fromJson(json) as T;

        break;

      case ErrorModel:
        return ErrorModel.fromMap(json) as T;
      default:
        break;
    }
  }
}