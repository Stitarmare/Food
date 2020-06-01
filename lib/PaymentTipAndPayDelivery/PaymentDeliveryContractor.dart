import 'package:flutter/material.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';

abstract class PaymentDeliveryContractor {
  void placeOrderDelivery(
    int userId,
    int restId,
    double totalAmount,
    String address,
    String landmark,
    String latitude,
    String longitude,
    List items,
    BuildContext context,
  );
  void onBackPresed();
}

abstract class PaymentDeliveryModelView {
  void placeOrdersuccess(OrderData orderData);
  void placeOrderfailed();
}
