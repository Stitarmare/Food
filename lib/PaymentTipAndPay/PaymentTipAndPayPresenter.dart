import 'package:flutter/material.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayContractor.dart';
import 'package:foodzi/Utils/String.dart';
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
  void onBackPresed() {}

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
    ApiBaseHelper()
        .post<PlaceOrderModel>(UrlConstant.placeOrderApi, context, body: {
      JSON_STR_USER_ID: userId,
      JSON_STR_REST_ID: restId,
      JSON_STR_ORDER_TYPE: orderType,
      JSON_STR_TABLE_ID: tableId,
      JSON_STR_TOTAL_AMOUNT: totalAmount,
      JSON_STR_LATITUDE: latitude,
      JSON_STR_LONGITUDE: longitude,
      JSON_STR_ITEMS: items
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          _paymentTipAndPayModelView.placeOrdersuccess(value.model.orderData);
          break;
        case SuccessType.failed:
          _paymentTipAndPayModelView.placeOrderfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
