import 'package:flutter/material.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';

abstract class TakeAwayRestaurantListContractor {

  void getrestaurantspage(String latitude, String longitude, String rating,
      String favourite,String sortByDistance,String sortByRating, int page,int delivery, BuildContext context);
  void onBackPresed();
}

abstract class TakeAwayRestaurantListModelView {
  void restaurantsuccess(List<RestaurantList> restlist);
  void restaurantfailed();
}
