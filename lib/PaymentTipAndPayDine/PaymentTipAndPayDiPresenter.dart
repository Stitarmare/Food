import 'package:flutter/material.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/MyOrders/MyOrderContractor.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class PaymentTipandPayDiPresenter extends PaymentTipandPayDiContractor {
  PaymentTipandPayDiModelView _paymentTipandPayDiModelView;
   PaymentTipandPayDiPresenter(
      PaymentTipandPayDiModelView _paymentTipandPayDiModelView) {
    this._paymentTipandPayDiModelView = _paymentTipandPayDiModelView;
  }

  @override
  void getOrderDetails(int orderid, BuildContext context) {
    ApiBaseHelper()
        .post<OrderDetailsModel>(UrlConstant.getorderDetails, context, body: {
      "order_id": orderid,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Order Detail success");
          print(value.model);
          _paymentTipandPayDiModelView.getOrderDetailsSuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Order Detail failed");
          _paymentTipandPayDiModelView.getOrderDetailsFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
    // TODO: implement getOrderDetails
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }
}
