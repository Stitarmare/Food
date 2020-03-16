import 'package:flutter/material.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';

abstract class StatusTrackViewContractor {
  void getOrderStatus(int orderId, BuildContext context);
  void getInvitedPeople(
      int orderId, int userId, int tableId, BuildContext context);
  void onBackPresed();
}

abstract class StatusTrackViewModelView {
  void getOrderStatussuccess(StatusData statusData);
  void getOrderStatusfailed();
  void getInvitedPeopleSuccess();
  void getInvitedPeopleFailed();
}
