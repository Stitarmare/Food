import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodzi/EditProfile/EditProfileContractor.dart';
import 'package:foodzi/Models/EditCityModel.dart';
import 'package:foodzi/Models/EditCountryModel.dart';
import 'package:foodzi/Models/EditStateModel.dart';
import 'package:foodzi/Models/UpdateprofileModel.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class EditProfilePresenter extends EditProfileContract {
  EditProfileModelView view;

  EditProfilePresenter(this.view);

  @override
  void editCity(String stateId, BuildContext context,bool showNetwrok) {
    ApiBaseHelper().post<EditCityModel>(UrlConstant.editCityField, context,
        body: {JSON_STR_STATE_ID: stateId},isShowNetwork: showNetwrok).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          view.editCitySuccess(value.model.data);
          break;
        case SuccessType.failed:
          view.editCityFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void editCountry(BuildContext context) {
    ApiBaseHelper()
        .post<EditCountryModel>(UrlConstant.editCountry, context)
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          view.editCountrySuccess(value.model.data);
          break;
        case SuccessType.failed:
          view.editCountryFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void editState(BuildContext context,bool showNetwrok) {
    ApiBaseHelper()
        .post<EditStateModel>(UrlConstant.editState, context,isShowNetwork: showNetwrok)
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          view.editStateSuccess(value.model.data);
          break;
        case SuccessType.failed:
          view.editStateFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void onBackPresed() {}

  @override
  void performUpdate(String fname, String lname, String address, int countryId,
      int stateId, int cityId, String postalCode, BuildContext context) {
    ApiBaseHelper()
        .post<UpdateProfileModel>(UrlConstant.updateProfile, context, body: {
      JSON_STR_FIRSTNAME: fname,
      JSON_STR_LASTNAME: lname,
      JSON_STR_ADDRESS: address,
      JSON_COUNTRY_ID: countryId,
      JSON_STATE_ID: stateId,
      JSON_CITY_ID: cityId,
      JSON_POSTAL_ID: postalCode
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model.data);
          Globle().loginModel.data = value.model.data;
          var userdata = json.encode(Globle().loginModel);
          Preference.setPersistData<String>(userdata, PreferenceKeys.User_data);
          view.profileUpdateSuccess();
          break;
        case SuccessType.failed:
          view.profileUpdateFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
