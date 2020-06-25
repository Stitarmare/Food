import 'package:flutter/material.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';

abstract class RestaurantTAContractor {
  void getMenuList(int restId, BuildContext context, {String menu, int page});
  void onBackPresed();
}

abstract class RestaurantTAModelView {
  void getMenuListsuccess(List<RestaurantMenuItem> menulist,
      RestaurantItemsModel restaurantItemsModel);
  void getMenuListfailed();
}
