import 'package:flutter/material.dart';
import 'package:foodzi/Models/CurrentOrderModel.dart';
import 'package:foodzi/Models/DeliveryBoyInfoModel.dart';
import 'package:foodzi/Models/GetMyOrdersBookingHistory.dart';
import 'package:foodzi/MyOrdersDelivery/MyOrdersDeliveryContractor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class MyOrdersDeliveryPresenter extends MyOrderDeliveryContractor {
  MyOrderDeliveryModelView _myOrderModelView;

  MyOrdersDeliveryPresenter(MyOrderDeliveryModelView _myOrderModelView) {
    this._myOrderModelView = _myOrderModelView;
  }

  @override
  void getOrderDetails(String orderType, BuildContext context) {
    ApiBaseHelper()
        .post<CurrentOrderDetailsModel>(UrlConstant.runningOrderApi, context,
            body: {
              JSON_STR_ORDER_TYPE: "delivery",
            },
            isShowDialoag: true)
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          _myOrderModelView.getOrderDetailsSuccess(value.model.data);
          break;
        case SuccessType.failed:
          _myOrderModelView.getOrderDetailsFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void getmyOrderBookingHistory(String orderType, BuildContext context) {
    ApiBaseHelper()
        .post<GetMyOrdersBookingHistory>(
            UrlConstant.getMyOrdersBookingHistory, context,
            body: {JSON_STR_ORDER_TYPE: orderType}, isShowDialoag: true)
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          _myOrderModelView.getmyOrderHistorySuccess(value.model.data);
          break;
        case SuccessType.failed:
          _myOrderModelView.getmyOrderHistoryFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  void getDeliveryBoyInfo(String orderId, BuildContext context) async {
    var responce = await ApiBaseHelper().post<DeliveryBoyInfoModel>(
        UrlConstant.getDeliveryBoyInfoApi, context,
        body: {"order_number": orderId});
    switch (responce.result) {
      case SuccessType.success:
        print(responce.model);
        _myOrderModelView.getDeliveryBoyDetailSuccess(responce.model.data);
        break;
      case SuccessType.failed:
        _myOrderModelView.getDeliveryBoyDetailFailed();
        break;
    }
  }

  @override
  void onBackPresed() {}
}
