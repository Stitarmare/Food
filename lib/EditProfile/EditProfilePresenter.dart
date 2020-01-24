

import 'package:flutter/material.dart';
import 'package:foodzi/EditProfile/EditProfileContractor.dart';
import 'package:foodzi/Models/EditCityModel.dart';
import 'package:foodzi/Models/EditCountryModel.dart';
import 'package:foodzi/Models/EditStateModel.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';


class EditProfilePresenter extends EditProfileContract{
  EditProfileModelView view;
  EditProfilePresenter(this.view);

  @override
  void editCity(String stateId, BuildContext context) {
    // TODO: implement editCity
        //  ApiBaseHelper().post<EditCityModel>(
        // UrlConstant.editCityField, context,body: {
        //   "state_id": stateId
        // })
        ApiBaseHelper().post<EditCityModel>(UrlConstant.editCityField, context,body: {"state_id": stateId})
        .then((value) {
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
     ApiBaseHelper().post<EditCountryModel>(
        UrlConstant.editCountry, context).then((value) {
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
       ApiBaseHelper().post<EditStateModel>(
        UrlConstant.editState, context).then((value) {
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
  void performUpdate(BuildContext context) {
    // TODO: implement performUpdate
  }
}