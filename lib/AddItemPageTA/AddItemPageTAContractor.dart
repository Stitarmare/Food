import 'package:flutter/material.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';

abstract class AddItemPageTAContractor {
  void performAddItem(int itemId, int restId, BuildContext context);
  void clearCart(BuildContext context);
  void onBackPresed();
}

abstract class AddItemPageTAModelView {
  void addItemsuccess(List<AddItemModelList> additemlist);
  void addItemfailed();
}

abstract class AddmenuToCartModelviews {
  void addMenuToCartsuccess();
  void addMenuToCartfailed();
}

abstract class ClearCartTAModelView {
  void clearCartSuccess();
  void clearCartFailed();
}
