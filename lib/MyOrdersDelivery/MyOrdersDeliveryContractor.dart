import 'package:flutter/material.dart';
import 'package:foodzi/Models/CurrentOrderModel.dart';
import 'package:foodzi/Models/GetMyOrdersBookingHistory.dart';

abstract class MyOrderDeliveryContractor {
  void getOrderDetails(
    String orderType,
    BuildContext context,
  );
  void getmyOrderBookingHistory(
    String orderType,
    BuildContext context,
  );
  void onBackPresed();
}

abstract class MyOrderDeliveryModelView {
  void getOrderDetailsSuccess(List<CurrentOrderList> _orderdetailsList);
  void getOrderDetailsFailed();
  void getmyOrderHistorySuccess(
      List<GetMyOrderBookingHistoryList> _getmyOrderBookingHistory);
  void getmyOrderHistoryFailed();
}
