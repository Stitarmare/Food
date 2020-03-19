import 'package:flutter/material.dart';
import 'package:foodzi/SplitBillPage/SplitBillContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';

class SplitBillPresenter extends SplitBillContractor {
  SplitBillContractorModelView _splitBillContractorModelView;
  @override
  void getSPlitBill(
      int order_id, int user_id, int option, int amount, BuildContext context) {
    // TODO: implement getSPlitBill
    ApiBaseHelper().post(UrlConstant.getSplitBillOption, context, body: {
      "order_id": order_id,
      "user_id": user_id,
      "option": option,
      "amount": amount,
    }).then((value) {
      switch (value.result) {
        case SuccessType.success:
          print(" Split Bill success");
          print(value.model);
          _splitBillContractorModelView.getSplitBillSuccess();
          break;
        case SuccessType.failed:
          print("Split Bill failed");
          _splitBillContractorModelView.getSplitBillFailed();
          break;
      }
    }).catchError((onError) {});
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }
}
