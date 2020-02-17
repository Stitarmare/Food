import 'package:flutter/material.dart';
import 'package:foodzi/Models/NotificationModel.dart';

abstract class NotoficationContractor {
  void getNotifications(BuildContext context);
  void onBackPresed();
}

abstract class NotificationModelView{
  void getNotificationsSuccess(List<NotificationData> getNotificationList);
  void getNotificationsFailed();
}