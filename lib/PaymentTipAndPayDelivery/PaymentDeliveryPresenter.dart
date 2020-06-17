import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetDeliveryChargeModel.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPayDelivery/PaymentDeliveryContractor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class PaymentDeliveryPresenter extends PaymentDeliveryContractor {
  PaymentDeliveryModelView _paymentTipAndPayModelView;
  PaymentDeliveryPresenter(
      PaymentDeliveryModelView _paymentTipAndPayModelView) {
    this._paymentTipAndPayModelView = _paymentTipAndPayModelView;
  }

  @override
  void onBackPresed() {}

  @override
  void placeOrderDelivery(
    int userId,
    int restId,
    double totalAmount,
    int deliveryCharge,
    String address,
    String landmark,
    String latitude,
    String longitude,
    List items,
    BuildContext context,
  ) async {
    var value = await ApiBaseHelper().post<PlaceOrderModel>(
        UrlConstant.placeOrderDeliveryApi, context,
        body: {
          JSON_STR_USER_ID: userId,
          JSON_STR_REST_ID: restId,
          JSON_STR_TOTAL_AMOUNT: totalAmount,
          JSON_STR_DELIVERY_CHARGE: deliveryCharge,
          JSON_STR_ADDRESS_HOUSENO: address,
          JSON_STR_LANDMARK: landmark,
          JSON_STR_LATITUDE: latitude,
          JSON_STR_LONGITUDE: longitude,
          JSON_STR_ITEMS: items
        });

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
  }

  @override
  void getDeliveryChargeDetails(String latitude, String longitude, int restId,
      BuildContext context) async {
    var value = await ApiBaseHelper().post<GetDeliveryChargeModel>(
        UrlConstant.getdeliverychargeApi, context, body: {
      "latitude": latitude,
      "longitude": longitude,
      "rest_id": restId
    });
    print(value);
    switch (value.result) {
      case SuccessType.success:
        print(value.model);
        _paymentTipAndPayModelView.getDeliveryDataSuccess(value.model.data);
        break;
      case SuccessType.failed:
        _paymentTipAndPayModelView.getDeliveryDataFailed();
        break;
    }
  }
}
