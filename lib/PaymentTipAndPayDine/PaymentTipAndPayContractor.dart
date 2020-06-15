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
  void getOrderDetailsSuccess(
      OrderDetailData orderData, OrderDetailsModel model);
  void getOrderDetailsFailed();
  void paymentCheckoutSuccess(PaymentCheckoutModel paymentCheckoutModel);
  void paymentCheckoutFailed();
  void cancelledPaymentSuccess();
  void cancelledPaymentFailed();
  void onSuccessQuantityIncrease();
  void onFailedQuantityIncrease();
}

abstract class PayFinalBillContaractor {
  void payfinalOrderBill(
    int restId,
    int userId,
    int orderId,
    String paymentMode,
    String amount,
    String totalAmount,
    String transacionId,
    BuildContext context, [
    String tip,
  ]);
}

abstract class PayFinalBillModelView {
  void payfinalBillSuccess();
  void payfinalBillFailed();
}

abstract class PayBillCheckoutContaractor {
  void payBillCheckOut(int restId, String amount, String tip, String currency,
      BuildContext context,
      {int orderId});
}

abstract class PayBillCheckoutModelView {
  void payBillCheckoutSuccess(PaycheckoutNetbanking model);
  void payBillCheckoutFailed();
}
