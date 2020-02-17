
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/NotificationModel.dart';
import 'package:foodzi/Notifications/NotificationContarctor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class NotificationPresenter extends NotoficationContractor {
  NotificationPresenter({this.notificationModelView});
  NotificationModelView notificationModelView;

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }

  @override
  void getNotifications(BuildContext context) {
    // TODO: implement getNotifications
        ApiBaseHelper().get<NotificationModel>(
        UrlConstant.getNotificationApi, context,
        ).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Notification success");
          print(value.model);
          notificationModelView.getNotificationsSuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Notification failed");
          notificationModelView.getNotificationsFailed();
          break;
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}
