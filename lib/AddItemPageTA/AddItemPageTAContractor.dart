import 'package:flutter/material.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';

abstract class AddItemPageTAContractor {
  void performAddItem(int item_id, int rest_id, BuildContext context);
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
