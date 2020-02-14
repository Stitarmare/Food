import 'package:flutter/material.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';

abstract class AddItemPageContractor {
  void performAddItem(int item_id, int rest_id, BuildContext context);
  void onBackPresed();
}

abstract class AddItemPageModelView {
  void addItemsuccess(List<AddItemModelList> additemlist);
  void addItemfailed();
}
