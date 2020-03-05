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

abstract class PayFinalBillContaractor {
  void payfinalOrderBill(
      int restId,
      int userId,
      int order_id,
      String payment_mode,
      double amount,
      double total_amount,
      BuildContext context);
}

abstract class PayFinalBillModelView {
  void payfinalBillSuccess();
  void payfinalBillFailed();
}
