import 'package:flutter/material.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';

abstract class RestaurantContractor {
  // void getrestaurantspage(String latitude, String longitude, String sort_by,
  //     String search_by, int page, BuildContext context);
  void getMenuList(int rest_id, BuildContext context, {String menu});
  void onBackPresed();
}

abstract class RestaurantModelView {
  // void restaurantsuccess(List<RestaurantList> restlist);
  // void restaurantfailed();
  void getMenuListsuccess(List<RestaurantMenuItem> menulist,
      RestaurantItemsModel restaurantItemsModel);
  void getMenuListfailed();
}
