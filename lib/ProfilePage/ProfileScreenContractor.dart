import 'package:flutter/material.dart';

abstract class ProfileScreenContractor {
  void updateProfileImage(String profileImgUrl,BuildContext context);
  void onBackPresed();
}

abstract class ProfileScreenModelView {
  void profileImageUpdateSuccess();
  void profileImageUpdateFailed();
}
