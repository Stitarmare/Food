import 'package:flutter/material.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class PaymentTipAndPayPresenter extends PaymentTipAndPayContarctor {
  PaymentTipAndPayModelView _paymentTipAndPayModelView;
  PaymentTipAndPayPresenter(
      PaymentTipAndPayModelView _paymentTipAndPayModelView) {
    this._paymentTipAndPayModelView = _paymentTipAndPayModelView;
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }

  @override
  void placeOrder(
    int restId,
    int userId,
    String orderType,
    int tableId,
    List items,
    int totalAmount,
    String latitude,
    String longitude,
    BuildContext context,
  ) {
    // TODO: implement getMenuList
    ApiBaseHelper()
        .post<PlaceOrderModel>(UrlConstant.placeOrderApi, context, body: {
      "user_id": userId,
      "rest_id": restId,
      "order_type": orderType,
      "table_id": tableId,
      "total_amount": totalAmount,
      "latitude": latitude,
      "longitude": longitude,
      "items": items
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Place Order success.");
          print(value.model);
          _paymentTipAndPayModelView.placeOrdersuccess(value.model.orderData);
          break;
        case SuccessType.failed:
          print("Place Order failed.");
          _paymentTipAndPayModelView.placeOrderfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
