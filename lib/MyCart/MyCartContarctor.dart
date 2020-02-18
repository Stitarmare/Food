import 'package:flutter/material.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';

abstract class MyCartContarctor {
  void getCartMenuList(int rest_id, BuildContext context, {String menu});
  void onBackPresed();
}

abstract class MyCartModelView {
  void getCartMenuListsuccess(List<AddMenuToCartList> menulist);
  void getCartMenuListfailed();
}
