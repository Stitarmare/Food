import 'package:flutter/material.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';

abstract class RestaurantContractor {
  void getMenuList(int restId, BuildContext context, {String menu});
  void onBackPresed();
}

abstract class RestaurantModelView {
  void getMenuListsuccess(List<RestaurantMenuItem> menulist,
      RestaurantItemsModel restaurantItemsModel);
  void getMenuListfailed();
}
