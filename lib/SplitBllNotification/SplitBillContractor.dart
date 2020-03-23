import 'package:flutter/material.dart';

abstract class SplitBillNotificationContractor {
  void getSPlitBillNotification(
      int order_id, int user_id, int option, int amount, BuildContext context);
  void onBackPresed();
}

abstract class SplitBillNotificationContractorModelView {
  void getSplitBillNotificationSuccess();
  void getSplitBillNotificationFailed();
}
