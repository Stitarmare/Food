import 'package:flutter/material.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';
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
  void getCartMenuListsuccess(List<MenuCartList> menulist);
  void getCartMenuListfailed();
  void removeItemSuccess();
  void removeItemFailed();
}
