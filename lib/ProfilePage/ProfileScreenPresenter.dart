import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodzi/Models/UpdateprofileModel.dart';
import 'package:foodzi/ProfilePage/ProfileScreenContractor.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class ProfileScreenPresenter extends ProfileScreenContractor {
  ProfileScreenModelView view;

  ProfileScreenPresenter(this.view);

  @override
  void updateProfileImage(String profileImgUrl, BuildContext context) {
    // TODO: implement updateProfileImage
    ApiBaseHelper().imageUpload<UpdateProfileModel>(
        UrlConstant.updateProfileImage, context,
        imageBody: {"profile_image": profileImgUrl}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Profile image Update Successfully");
          print(value.model.data);
          Globle().loginModel.data = value.model.data;
          var userdata = json.encode(Globle().loginModel);
          Preference.setPersistData<String>(userdata, PreferenceKeys.User_data);
          view.profileImageUpdateSuccess();
          break;
        case SuccessType.failed:
          print("failed");
          view..profileImageUpdateFailed();
          break;
      }
      // if (value['status_code'] == 200) {
      //   Globle().loginModel = LoginModel.fromJson(value);

      //   otpView.otpsuccess();
      // }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }
}
