import 'package:flutter/material.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';

abstract class DineInDeliveryContractor {
  void getrestaurantspage(String latitude, String longitude, String sortBy,
      String searchBy, int page, int delivery, BuildContext context);
  void onBackPresed();
}

abstract class DineInDeliveryModelView {
  void restaurantsuccess(List<RestaurantList> restlist);
  void restaurantfailed();
}
