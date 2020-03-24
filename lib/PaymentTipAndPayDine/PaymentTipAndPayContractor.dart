import 'package:flutter/material.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/PayCheckOutNetBanking.dart';
import 'package:foodzi/Models/payment_Checkout_model.dart';

abstract class PaymentTipandPayDiContractor {
  void getOrderDetails(
    int orderid,
    BuildContext context,
  );
  void onBackPresed();
  void getCheckoutDetails(
    String checkoutId,
    BuildContext context,
  );
}

abstract class PaymentTipandPayDiModelView {
  void getOrderDetailsSuccess(OrderDetailData orderData);
  void getOrderDetailsFailed();
  void paymentCheckoutSuccess(PaymentCheckoutModel paymentCheckoutModel);
  void paymentCheckoutFailed();
}

abstract class PayFinalBillContaractor {
  void payfinalOrderBill(
    int restId,
    int userId,
    int order_id,
    String payment_mode,
    int amount,
    int total_amount,
    String transacionId,
    BuildContext context, [
    int tip,
  ]);
}

abstract class PayFinalBillModelView {
  void payfinalBillSuccess();
  void payfinalBillFailed();
}

abstract class PayBillCheckoutContaractor {
  void payBillCheckOut(
      int restId,
      // String currency,
      int amount,
      BuildContext context);
}

abstract class PayBillCheckoutModelView {
  void payBillCheckoutSuccess(PaycheckoutNetbanking model);
  void payBillCheckoutFailed();
}
