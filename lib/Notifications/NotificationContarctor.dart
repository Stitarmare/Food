import 'package:flutter/material.dart';
import 'package:foodzi/Models/NotificationModel.dart';
import 'package:foodzi/Models/error_model.dart';

abstract class NotoficationContractor {
  void getNotifications(BuildContext context);
  void onBackPresed();
  
//  void acceptInvitation(int from_id, int table_id, int rest_id, int order_id, String status, BuildContext context);
}

abstract class NotificationModelView{
  void getNotificationsSuccess(List<Datum> getNotificationList);
  void getNotificationsFailed();

  void acceptInvitationSuccess(ErrorModel model);
  void acceptInvitationFailed(ErrorModel model);
  
}