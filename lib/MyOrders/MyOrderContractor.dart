import 'package:flutter/material.dart';
import 'package:foodzi/Models/CurrentOrderModel.dart';
import 'package:foodzi/Models/GetMyOrdersBookingHistory.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';

abstract class MyOrderContractor {
  void getOrderDetails(
    String order_type,
    BuildContext context,
  );
  void getmyOrderBookingHistory(
    String order_type,
    BuildContext context,
  );
  void onBackPresed();
}

abstract class MyOrderModelView {
  void getOrderDetailsSuccess(List<CurrentOrderList> _orderdetailsList);
  //List<CurrentOrderList> _orderdetailsList);
  void getOrderDetailsFailed();
  void getmyOrderHistorySuccess(
      List<GetMyOrderBookingHistoryList> _getmyOrderBookingHistory);
  void getmyOrderHistoryFailed();
}
