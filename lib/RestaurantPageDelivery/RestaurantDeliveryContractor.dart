import 'package:flutter/material.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';

abstract class RestaurantDeliveryContractor {
  void getMenuList(int restId, BuildContext context, {String menu, int page});
  void notifyWaiter(
      int userId, int tableId, String deviceToken, BuildContext context);
  void onBackPresed();
}

abstract class RestaurantDeliveryModelView {
  void getMenuListsuccess(List<RestaurantMenuItem> menulist,
      RestaurantItemsModel restaurantItemsModel);
  void getMenuListfailed();
  void notifyWaiterSuccess();
  void notifyWaiterFailed();
}
