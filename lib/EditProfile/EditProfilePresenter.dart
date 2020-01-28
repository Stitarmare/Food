import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodzi/EditProfile/EditProfileContractor.dart';
import 'package:foodzi/Models/EditCityModel.dart';
import 'package:foodzi/Models/EditCountryModel.dart';
import 'package:foodzi/Models/EditStateModel.dart';
import 'package:foodzi/Models/UpdateprofileModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Models/loginmodel.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class EditProfilePresenter extends EditProfileContract {
  EditProfileModelView view;

  
  EditProfilePresenter(this.view);

  @override
  void editCity(String stateId, BuildContext context) {
    // TODO: implement editCity
    //  ApiBaseHelper().post<EditCityModel>(
    // UrlConstant.editCityField, context,body: {
    //   "state_id": stateId
    // })
    ApiBaseHelper().post<EditCityModel>(UrlConstant.editCityField, context,
        body: {"state_id": stateId}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("City success");
          print(value.model);
          //restaurantModelView.restaurantsuccess(value.model.data);
          view.editCitySuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Restaurant failed");
          //restaurantModelView.restaurantfailed();
          view.editCityFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void editCountry(BuildContext context) {
    // TODO: implement editCountry
    ApiBaseHelper()
        .post<EditCountryModel>(UrlConstant.editCountry, context)
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Country success");
          print(value.model);
          //restaurantModelView.restaurantsuccess(value.model.data);
          view.editCountrySuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Restaurant failed");
          //restaurantModelView.restaurantfailed();
          view.editCountryFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void editState(BuildContext context) {
    ApiBaseHelper()
        .post<EditStateModel>(UrlConstant.editState, context)
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("State success");
          print(value.model);
          view.editStateSuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Restaurant failed");
          view.editStateFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }

  @override
  void performUpdate(String fname, String lname, String address, int countryId,
      int stateId, int cityId, String postalCode, BuildContext context) {
    // TODO: implement performUpdate
    ApiBaseHelper()
        .post<UpdateProfileModel>(UrlConstant.updateProfile, context, body: {
      'first_name': fname,
      'last_name': lname,
      'address_line_1': address,
      'country_id': countryId,
      'state_id': stateId,
      'city_id': cityId,
      'postal_code': postalCode
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Update Successfully");
          print(value.model.data);
          Globle().loginModel.data = value.model.data;
          var userdata = json.encode(Globle().loginModel);
          Preference.setPersistData<String>(userdata, PreferenceKeys.User_data);
          //Globle().loginModel.data = value.model;
          //Globle().loginModel = LoginModel.fromJson(value.model.data);
          view.profileUpdateSuccess();
          break;
        case SuccessType.failed:
          print("failed");
          view.profileUpdateFailed();
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


}
