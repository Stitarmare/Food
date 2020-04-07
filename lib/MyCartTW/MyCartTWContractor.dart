import 'package:flutter/material.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';

abstract class MyCartTWContarctor {
  void getCartMenuList(
    int restId,
    BuildContext context,
    int userId,
  );
  void onBackPresed();
  void removeItemfromCart(int cartId, int userId, BuildContext context);
}

abstract class MyCartTWModelView {
  void getCartMenuListsuccess(
      List<MenuCartList> menulist, MenuCartDisplayModel model);
  void getCartMenuListfailed();
  void removeItemSuccess();
  void removeItemFailed();
  void updatequantitySuccess();
  void updatequantityfailed();
}
