import 'package:flutter/material.dart';
import 'package:foodzi/Models/CurrentOrderModel.dart';
import 'package:foodzi/Models/GetMyOrdersBookingHistory.dart';

abstract class MyOrderContractor {
  void getOrderDetails(
    String orderType,
    BuildContext context,
  );
  void getmyOrderBookingHistory(
    String orderType,
    BuildContext context,
    bool isNetwrokShow
  );
  void onBackPresed();
}

abstract class MyOrderModelView {
  void getOrderDetailsSuccess(List<CurrentOrderList> _orderdetailsList);
  void getOrderDetailsFailed();
  void getmyOrderHistorySuccess(
      List<GetMyOrderBookingHistoryList> _getmyOrderBookingHistory);
  void getmyOrderHistoryFailed();
}
