import 'package:flutter/material.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';
import 'package:foodzi/Models/GetTableListModel.dart';
import 'package:foodzi/Models/UpdateOrderModel.dart';

abstract class AddItemDeliveryContractor {
  void performAddItem(int itemId, int restId, BuildContext context);
  void clearCart(BuildContext context);
  void updateOrder(UpdateOrderModel updateOrderModel, BuildContext context);
  void onBackPresed();
}

abstract class AddItemDeliveryModelView {
  void addItemsuccess(List<AddItemModelList> additemlist,
      AddItemPageModelList addItemPageModelList);
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
