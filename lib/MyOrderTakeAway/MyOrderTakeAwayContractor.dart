import 'package:flutter/material.dart';
import 'package:foodzi/Models/CurrentOrderModel.dart';
import 'package:foodzi/Models/GetMyOrdersBookingHistory.dart';

abstract class MyOrderTakeAwayContractor {
  void getOrderDetails(
    String orderType,
    BuildContext context,
  );
  void getmyOrderBookingHistory(
    BuildContext context,
  );
  void onBackPresed();
}

abstract class MyOrderTakeAwayModelView {
  void getOrderDetailsSuccess(List<CurrentOrderList> _orderdetailsList);
  void getOrderDetailsFailed();
  void getmyOrderHistorySuccess(
      List<GetMyOrderBookingHistoryList> _getmyOrderBookingHistory);
  void getmyOrderHistoryFailed();
}
