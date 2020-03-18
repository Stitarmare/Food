
import 'package:flutter/material.dart';
import 'package:foodzi/Models/running_order_model.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

abstract class LandingViewProtocol{
  void onSuccessCurrentOrder(RunningOrderModel model);
  void onFailedCurrentOrder();
}

class LandingViewPresenter {
  final LandingViewProtocol protocol;

  LandingViewPresenter(this.protocol);

  void getCurrentOrder(BuildContext context) {
    ApiBaseHelper().get<RunningOrderModel>(UrlConstant.getCurrentOrders, context).then((value){
      switch (value.result) {
        case SuccessType.success:
          // TODO: Handle this case.
          protocol.onSuccessCurrentOrder(value.model);
          break;
        case SuccessType.failed:
          // TODO: Handle this case.
          protocol.onFailedCurrentOrder();
          break;
      }
    }).catchError((error){
      protocol.onFailedCurrentOrder();
    });
  }

}