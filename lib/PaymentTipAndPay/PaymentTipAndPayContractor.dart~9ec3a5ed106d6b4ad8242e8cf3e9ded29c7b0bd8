import 'package:flutter/material.dart';
import 'package:foodzi/Models/Otpverify.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';

abstract class PaymentTipAndPayContarctor {
  void placeOrder(int restId, int userId,String orderType, int tableId,List items,int totalAmount,String latitude, String longitude,BuildContext context,);
  void onBackPresed();
}

abstract class PaymentTipAndPayModelView {
  void placeOrdersuccess(OrderData orderData);
  void placeOrderfailed();
}