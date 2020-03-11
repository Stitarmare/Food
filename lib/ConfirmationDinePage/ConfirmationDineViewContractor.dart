import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';

abstract class ConfirmationDineViewContractor {
  void addPeople(String mobile_number, int table_id, int rest_id, int order_id,
      BuildContext context);

  void getPeopleList(BuildContext context);
}

abstract class ConfirmationDineViewModelView {
  void addPeopleSuccess();
  void addPeopleFailed();

  void getPeopleListonSuccess(List<Data> data);
  void getPeopleListonFailed();
}
