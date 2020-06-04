import 'package:flutter/material.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';

abstract class DineInRestaurantListContractor {
  void getrestaurantspage(String latitude, String longitude, String rating,
      String favourite,String sortByDistance,String sortByRating, int page, BuildContext context);
  void onBackPresed();
}

abstract class DineInRestaurantListModelView {
  void restaurantsuccess(List<RestaurantList> restlist);
  void restaurantfailed();
}
