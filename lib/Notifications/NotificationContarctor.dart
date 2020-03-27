import 'package:flutter/material.dart';
import 'package:foodzi/Models/NotificationModel.dart';
import 'package:foodzi/Models/error_model.dart';

abstract class NotoficationContractor {
  void getNotifications(BuildContext context);
  void onBackPresed();
}

abstract class NotificationModelView {
  void getNotificationsSuccess(List<Datum> getNotificationList);
  void getNotificationsFailed();

  void acceptInvitationSuccess(ErrorModel model);
  void acceptInvitationFailed(ErrorModel model);
}
