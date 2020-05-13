import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetTableListModel.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';

abstract class MyCartDeliveryContarctor {
  void getCartMenuList(
    int restId,
    BuildContext context,
    int userId,
  );
  void onBackPresed();

  void removeItemfromCart(int cartId, int userId, BuildContext context);
}

abstract class MyCartDeliveryModelView {
  void getCartMenuListsuccess(
      List<MenuCartList> menulist, MenuCartDisplayModel model);
  void getCartMenuListfailed();
  void removeItemSuccess();
  void removeItemFailed();
  void updatequantitySuccess();
  void updatequantityfailed();
}

abstract class AddTablenoModelView {
  void addTablebnoSuccces();
  void addTablenofailed();
}

abstract class GetTableListModelView {
  void getTableListSuccess(List<GetTableList> getlist);
  void getTableListFailed();
}
