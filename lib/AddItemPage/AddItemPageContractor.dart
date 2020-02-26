import 'package:flutter/material.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';
import 'package:foodzi/Models/GetTableListModel.dart';

abstract class AddItemPageContractor {
  void performAddItem(int item_id, int rest_id, BuildContext context);
  void onBackPresed();
}

abstract class AddItemPageModelView {
  void addItemsuccess(List<AddItemModelList> additemlist);
  void addItemfailed();
}
<<<<<<< HEAD
=======

abstract class AddTablenoModelView {
  void addTablebnoSuccces();
  void addTablenofailed();
}

abstract class AddmenuToCartModelview {
  void addMenuToCartsuccess();
  void addMenuToCartfailed();
}

abstract class GetTableListModelView {
  void getTableListSuccess(List<GetTableList> getlist);
  void getTableListFailed();
}
>>>>>>> 9ec3a5ed106d6b4ad8242e8cf3e9ded29c7b0bd8
