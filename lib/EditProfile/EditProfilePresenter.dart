import 'dart:js';

import 'package:flutter/material.dart';
import 'package:foodzi/models/EditCountryModel.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/url_constant.dart';

abstract class EditProfilePresenterInterface {
  void countrySuccess();
  void countryFailed();
  void stateSuccess();
  void stateFailed();
  void citySuccess();
  void cityFailed();
}
class EditProfilePresenter {
  EditProfilePresenterInterface view;
  EditProfilePresenter({this.view});

  editCountryApi(BuildContext context) {
    
  }
}