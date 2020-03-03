import 'package:flutter/material.dart';

abstract class MyOrderContractor {
  void getOrderDetails(
    int orderid,
  );
  void onBackPresed();
}

abstract class MyOrderModelView {
  void getOrderDetailsSuccess();
  void getOrderDetailsFailed();
}
