import 'package:flutter/material.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';

abstract class PaymentTipandPayDiContractor {
  void getOrderDetails(
    int orderid,
    BuildContext context,
  );
  void onBackPresed();
}

abstract class PaymentTipandPayDiModelView {
  void getOrderDetailsSuccess(Data orderData);
  void getOrderDetailsFailed();
}