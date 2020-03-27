import 'package:flutter/material.dart';
import 'package:foodzi/SplitBllNotification/SplitBillContractor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplitBillNotificationPresenter extends SplitBillNotificationContractor {
  SplitBillNotificationContractorModelView _splitBillContractorModelView;

  SplitBillNotificationPresenter(
      SplitBillNotificationContractorModelView _splitBillContractorModelView) {
    this._splitBillContractorModelView = _splitBillContractorModelView;
  }

  @override
  void onBackPresed() {}

  @override
  void getSPlitBillNotification(
      int orderId, int userId, int option, int amount, BuildContext context) {
    ApiBaseHelper().post(UrlConstant.getSPlitBillNotification, context, body: {
      JSON_STR_ORDER_ID: orderId,
      JSON_STR_USERS: userId,
      JSON_STR_AMOUNT: amount,
    }).then((value) {
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          _splitBillContractorModelView.getSplitBillNotificationSuccess();
          break;
        case SuccessType.failed:
          _splitBillContractorModelView.getSplitBillNotificationFailed();
          break;
      }
    }).catchError((onError) {});
  }
}
