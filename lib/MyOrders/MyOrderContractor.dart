import 'package:flutter/material.dart';
import 'package:foodzi/Models/CurrentOrderModel.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';

abstract class MyOrderContractor {
  void getOrderDetails(
    BuildContext context,
  );
  void onBackPresed();
}

abstract class MyOrderModelView {
  void getOrderDetailsSuccess(List<CurrentOrderList> _orderdetailsList);
  void getOrderDetailsFailed();
}
