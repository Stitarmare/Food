import 'package:flutter/material.dart';

abstract class SplitBillContractor {
  void getSPlitBill(
      int order_id, int user_id, int option, int amount, BuildContext context);
  void onBackPresed();
}

abstract class SplitBillContractorModelView {
  void getSplitBillSuccess();
  void getSplitBillFailed();
}
