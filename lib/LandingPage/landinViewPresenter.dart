import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Models/running_order_model.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

abstract class LandingViewProtocol {
  void onSuccessCurrentOrder(RunningOrderModel model);
  void onFailedCurrentOrder();
}

class LandingViewPresenter {
  final LandingViewProtocol protocol;

  LandingViewPresenter(this.protocol);

  void getCurrentOrder(BuildContext context) {
    ApiBaseHelper()
        .get<RunningOrderModel>(UrlConstant.getCurrentOrders, context)
        .then((value) {
      switch (value.result) {
        case SuccessType.success:
          protocol.onSuccessCurrentOrder(value.model);
          break;
        case SuccessType.failed:
          protocol.onFailedCurrentOrder();
          break;
      }
    });
  }

  void sendDeviceInfo(String latitude,String longitude,BuildContext context) async{
    var value = await ApiBaseHelper().post<ErrorModel>(UrlConstant.deviceInfo, context,body:
    {
      "device_token":Globle().fcmToken,
      "device_type": Platform.isIOS ? "1" : "2",
      "latitude":latitude,
      "longitude":longitude
    },isShowDialoag: true);
    switch (value.result) {
        case SuccessType.success:
          
          break;
        case SuccessType.failed:
          
          break;
      }
  }

}
