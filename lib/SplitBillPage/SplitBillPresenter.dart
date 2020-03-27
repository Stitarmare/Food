import 'package:flutter/material.dart';
import 'package:foodzi/SplitBillPage/SplitBillContractor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class SplitBillPresenter extends SplitBillContractor {
  SplitBillContractorModelView _splitBillContractorModelView;

  SplitBillPresenter(
      SplitBillContractorModelView _splitBillContractorModelView) {
    this._splitBillContractorModelView = _splitBillContractorModelView;
  }
  @override
  void getSPlitBill(
      int orderId, int userId, int option, int amount, BuildContext context) {
    ApiBaseHelper().post(UrlConstant.getSplitBillOption, context, body: {
      JSON_STR_ORDER_ID: orderId,
      JSON_STR_USER_ID: userId,
      JSON_STR_OPTION: option,
      JSON_STR_AMOUNT: amount,
    }).then((value) {
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          _splitBillContractorModelView.getSplitBillSuccess();
          break;
        case SuccessType.failed:
          _splitBillContractorModelView.getSplitBillFailed();
          break;
      }
    }).catchError((onError) {});
  }

  @override
  void onBackPresed() {}
}
