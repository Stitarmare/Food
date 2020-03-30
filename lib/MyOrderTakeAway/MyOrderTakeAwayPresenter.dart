import 'package:flutter/material.dart';
import 'package:foodzi/Models/CurrentOrderModel.dart';
import 'package:foodzi/Models/GetMyOrdersBookingHistory.dart';
import 'package:foodzi/MyOrderTakeAway/MyOrderTakeAwayContractor.dart';
import 'package:foodzi/MyOrders/MyOrderContractor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class MyOrderTakeAwayPresenter extends MyOrderContractor {
  MyOrderTakeAwayModelView _myOrderModelView;

  MyOrderTakeAwayPresenter(MyOrderTakeAwayModelView _myOrderModelView) {
    this._myOrderModelView = _myOrderModelView;
  }

  @override
  void getOrderDetails(String orderType, BuildContext context) {
    ApiBaseHelper().post<CurrentOrderDetailsModel>(
        UrlConstant.runningOrderApi, context,
        body: {
          JSON_STR_ORDER_TYPE: orderType,
        }).then((value) {
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
    ApiBaseHelper().post<GetMyOrdersBookingHistory>(
        UrlConstant.getMyOrdersBookingHistory, context,
        body: {
          JSON_STR_ORDER_TYPE: orderType,
        }).then((value) {
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

  @override
  void onBackPresed() {}
}
