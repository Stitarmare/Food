import 'package:flutter/material.dart';

abstract class SplitBillContractor {
  void getSPlitBill(int orderId, int userId, int option, int amount,
      int ownerId, BuildContext context);
  void onBackPresed();
}

abstract class SplitBillContractorModelView {
  void getSplitBillSuccess();
  void getSplitBillFailed();
}
