import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetTableListModel.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';

abstract class MyCartContarctor {
  void getCartMenuList(
    int restId,
    BuildContext context,
    int userId,
  );
  void onBackPresed();

  void removeItemfromCart(int cartId, int userId, BuildContext context);
  void placeOrderCartItemsList(
      int userId,
      int restId,
      int orderId,
      String orderType,
      int tableId,
      String longitude,
      String latitude,
      List<dynamic> items,
      BuildContext context);
}

abstract class MyCartModelView {
  void getCartMenuListsuccess(
      List<MenuCartList> menulist, MenuCartDisplayModel model);
  void getCartMenuListfailed();
  void removeItemSuccess();
  void removeItemFailed();
  void updatequantitySuccess();
  void updatequantityfailed();
  void placeOrderCartSuccess(OrderData data);
  void placeOrderCartFailed();
}

abstract class AddTablenoModelView {
  void addTablebnoSuccces();
  void addTablenofailed();
}

abstract class GetTableListModelView {
  void getTableListSuccess(List<GetTableList> getlist);
  void getTableListFailed();
}
