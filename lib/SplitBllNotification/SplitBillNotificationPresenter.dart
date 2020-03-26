import 'package:flutter/material.dart';
import 'package:foodzi/SplitBillPage/SplitBillContractor.dart';
import 'package:foodzi/SplitBllNotification/SplitBillContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';

class SplitBillNotificationPresenter extends SplitBillNotificationContractor {
  SplitBillNotificationContractorModelView _splitBillContractorModelView;

  SplitBillNotificationPresenter(
      SplitBillNotificationContractorModelView _splitBillContractorModelView) {
    this._splitBillContractorModelView = _splitBillContractorModelView;
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }

  @override
  void getSPlitBillNotification(
      int order_id, int user_id, int option, int amount, BuildContext context) {
    // TODO: implement getSPlitBillNotification
    ApiBaseHelper().post(UrlConstant.getSPlitBillNotification, context, body: {
      "order_id": order_id,
      "users": user_id,
      "amount": amount,
    }).then((value) {
      switch (value.result) {
        case SuccessType.success:
          print(" Split Bill Notification success");
          print(value.model);
          _splitBillContractorModelView.getSplitBillNotificationSuccess();
          break;
        case SuccessType.failed:
          print("Split Bill Notification failed");
          _splitBillContractorModelView.getSplitBillNotificationFailed();
          break;
      }
    }).catchError((onError) {});
  }
}
