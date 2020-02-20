import 'package:flutter/material.dart';

abstract class PaymentTipAndPayContarctor {
  void placeOrder(int restId, int userId,String orderType, int tableId,List items,double totalAmount,BuildContext context,);
  void onBackPresed();
}

abstract class PaymentTipAndPayModelView {
  void placeOrdersuccess(List menulist);
  void placeOrderfailed();
}