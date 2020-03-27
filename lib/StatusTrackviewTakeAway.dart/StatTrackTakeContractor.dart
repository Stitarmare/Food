import 'package:flutter/material.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';

abstract class StatTrackTakeContractor {
  void getOrderStatus(int orderId, BuildContext context);
  void onBackPresed();
}

abstract class StatTrackTakeModelView {
  void getOrderStatussuccess(StatusData statusData);
  void getOrderStatusfailed();
}
