import 'package:flutter/material.dart';

abstract class ConfirmationDineViewContractor {
  void addPeople(
      int mobile_number, int table_id, int rest_id, BuildContext context);
}

abstract class ConfirmationDineViewModelView {
  void addPeopleSuccess();
  void addPeopleFailed();
}
