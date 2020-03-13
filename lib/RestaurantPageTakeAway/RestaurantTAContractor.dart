import 'package:flutter/material.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';

abstract class RestaurantTAContractor {
  // void getrestaurantspage(String latitude, String longitude, String sort_by,
  //     String search_by, int page, BuildContext context);
  void getMenuList(int rest_id, BuildContext context, {String menu});
  void onBackPresed();
}

abstract class RestaurantTAModelView {
  // void restaurantsuccess(List<RestaurantList> restlist);
  // void restaurantfailed();
  void getMenuListsuccess(List<RestaurantMenuItem> menulist);
  void getMenuListfailed();
}
