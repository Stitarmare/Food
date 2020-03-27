import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/UpdateprofileModel.dart';
import 'package:foodzi/ProfilePage/ProfileScreenContractor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class ProfileScreenPresenter extends ProfileScreenContractor {
  ProfileScreenModelView view;

  ProfileScreenPresenter(this.view);

  @override
  void updateProfileImage(File profileImgUrl, BuildContext context) {
    ApiBaseHelper()
        .imageUpload<UpdateProfileModel>(
            UrlConstant.updateProfileImage, context,
            key: JSON_STR_PROFILE_IMAGE, imageBody: profileImgUrl)
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model.data);
          Globle().loginModel.data = value.model.data;
          var userdata = json.encode(Globle().loginModel);
          Preference.setPersistData<String>(userdata, PreferenceKeys.User_data);
          view.profileImageUpdateSuccess();
          break;
        case SuccessType.failed:
          view..profileImageUpdateFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void onBackPresed() {}
}
