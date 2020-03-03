import 'package:flutter/material.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';
import 'package:foodzi/Models/GetTableListModel.dart';

abstract class AddItemPageContractor {
  void performAddItem(int item_id, int rest_id, BuildContext context);
   void clearCart(BuildContext context) ;
   void updateOrder(int orderId,BuildContext context);
  void onBackPresed();
}

abstract class AddItemPageModelView {
  void addItemsuccess(List<AddItemModelList> additemlist);
  void addItemfailed();
}

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
abstract class ClearCartModelView {
  void clearCartSuccess();
  void clearCartFailed();
}
abstract class UpdateCartModelView {
  void updateOrderSuccess();
  void updateOrderFailed();
}
