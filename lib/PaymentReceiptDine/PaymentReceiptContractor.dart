import 'package:flutter/material.dart';

abstract class PaymentReceiptContractor {
  void getPaymentReceipt(int orderId, String emailId, BuildContext context);
}

abstract class PaymentReceiptModalView {
  void onSuccessPaymentReceipt(String message);
  void onFailedPaymentReceipt();
}
