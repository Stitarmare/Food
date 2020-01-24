import 'package:flutter/material.dart';
import 'package:foodzi/Models/EditCityModel.dart';
import 'package:foodzi/Models/EditCountryModel.dart';
import 'package:foodzi/Models/EditStateModel.dart';

abstract class EditProfileContract {
  void performUpdate(BuildContext context);
  void editCountry(BuildContext context);
  void editState(BuildContext context);
  void editCity(String stateId,BuildContext context);
  void onBackPresed();
}

abstract class EditProfileModelView {
  void editCountrySuccess(List<CountryList> countryList);
  void editCountryFailed();
  void editStateSuccess(List<StateList> stateList);
  void editStateFailed();
  void editCitySuccess(List<CityList> stateList);
  void editCityFailed();
}
