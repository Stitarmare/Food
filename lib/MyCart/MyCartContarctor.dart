import 'package:flutter/material.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';

abstract class MyCartContarctor {
  void getCartMenuList(int restId, BuildContext context, int userId,);
  void onBackPresed();
}

abstract class MyCartModelView {
  void getCartMenuListsuccess(List<AddMenuToCartList> menulist);
  void getCartMenuListfailed();
}
