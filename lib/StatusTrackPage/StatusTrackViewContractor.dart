import 'package:flutter/material.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';

abstract class StatusTrackViewContractor {
  void getOrderStatus(int orderId, BuildContext context);
  void onBackPresed();
}

abstract class TakeAwayRestaurantListModelView {
  void getOrderStatussuccess();
  void getOrderStatusfailed();
}