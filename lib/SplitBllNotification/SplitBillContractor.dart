import 'package:flutter/material.dart';

abstract class SplitBillNotificationContractor {
  void getSPlitBillNotification(
      int orderId, int userId, int option, int amount, BuildContext context);
  void onBackPresed();
}

abstract class SplitBillNotificationContractorModelView {
  void getSplitBillNotificationSuccess();
  void getSplitBillNotificationFailed();
}
