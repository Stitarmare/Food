import 'package:flutter/material.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';
import 'package:foodzi/Models/GetTableListModel.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';

abstract class MyCartContarctor {
  void getCartMenuList(
    int restId,
    BuildContext context,
    int userId,
  );
  void onBackPresed();

  void removeItemfromCart(int cartId, int userId, BuildContext context);
}

abstract class MyCartModelView {
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
