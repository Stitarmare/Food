import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/PaymentReceiptDine/PaymentReceiptContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class PayementReceiptPresenter extends PaymentReceiptContractor {
  PaymentReceiptModalView paymentReceiptModalView;
  PayementReceiptPresenter(PaymentReceiptModalView paymentReceiptModalView) {
    this.paymentReceiptModalView = paymentReceiptModalView;
  }
  @override
  void getPaymentReceipt(int orderId, String emailId, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.orderBillApi, context,
        body: {"id": orderId, "to_recipient": emailId}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          paymentReceiptModalView.onSuccessPaymentReceipt(value.model.message);
          break;
        case SuccessType.failed:
          paymentReceiptModalView.onFailedPaymentReceipt();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
