import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';

abstract class ConfirmationDineViewContractor {
  void addPeople(String mobileNumber, int tableId, int restId, int orderId,
      BuildContext context);

  void getPeopleList(BuildContext context);
}

abstract class ConfirmationDineViewModelView {
  void addPeopleSuccess();
  void addPeopleFailed();

  void getPeopleListonSuccess(List<PeopleData> data);
  void getPeopleListonFailed();
}
