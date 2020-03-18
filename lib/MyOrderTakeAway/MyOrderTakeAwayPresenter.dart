import 'package:flutter/material.dart';
import 'package:foodzi/Models/CurrentOrderModel.dart';
import 'package:foodzi/Models/GetMyOrdersBookingHistory.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/MyOrderTakeAway/MyOrderTakeAwayContractor.dart';
import 'package:foodzi/MyOrders/MyOrderContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class MyOrderTakeAwayPresenter extends MyOrderContractor {
  MyOrderTakeAwayModelView _myOrderModelView;

  MyOrderTakeAwayPresenter(MyOrderTakeAwayModelView _myOrderModelView) {
    this._myOrderModelView = _myOrderModelView;
  }

  @override
  void getOrderDetails(String order_type, BuildContext context) {
    ApiBaseHelper().post<CurrentOrderDetailsModel>(
        UrlConstant.runningOrderApi, context,
        body: {
          "order_type": order_type,
        }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Add People Success");
          print(value.model);
          _myOrderModelView.getOrderDetailsSuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Add People Failed");
          _myOrderModelView.getOrderDetailsFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  // @override
  // void getOrderDetails(BuildContext context) {
  //   ApiBaseHelper()
  //       .get<CurrentOrderDetailsModel>(UrlConstant.runningOrderApi, context)
  //       .then((value) {
  //     print(value);
  //     switch (value.result) {
  //       case SuccessType.success:
  //         print("Order Detail success");
  //         print(value.model);
  //         _myOrderModelView.getOrderDetailsSuccess(value.model.data);
  //         break;
  //       case SuccessType.failed:
  //         print("Order Detail failed");
  //         _myOrderModelView.getOrderDetailsFailed();
  //         break;
  //     }
  //   }).catchError((error) {
  //     print(error);
  //   });
  //   // TODO: implement getOrderDetails
  // }

  @override
  void getmyOrderBookingHistory(String order_type, BuildContext context) {
    ApiBaseHelper().post<GetMyOrdersBookingHistory>(
        UrlConstant.getMyOrdersBookingHistory, context,
        body: {
          "order_type": order_type,
        }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Order History success");
          print(value.model);
          _myOrderModelView.getmyOrderHistorySuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Order History failed");
          _myOrderModelView.getmyOrderHistoryFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }
}
