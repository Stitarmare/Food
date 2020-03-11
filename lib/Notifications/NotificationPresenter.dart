
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/NotificationModel.dart';
import 'package:foodzi/Models/error_model.dart';
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
        ApiBaseHelper().get<GetNotificationListModel>(
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

  @override
  void acceptInvitation(int from_id, int invitation_id, String status, BuildContext context) {
    // TODO: implement acceptInvitation
    ApiBaseHelper().post<ErrorModel>(UrlConstant.acceptInvitationApi, context,body: {
      "from_id":from_id,
      "invitation_id":invitation_id,
      // "table_id":table_id,
      // "rest_id":rest_id,
      "status":status,
      // "order_id":order_id
    }).then((value){
      print(value);
      switch (value.result){
        case SuccessType.success:
        notificationModelView.acceptInvitationSuccess(value.model);
        break;
        case SuccessType.failed:
        notificationModelView.acceptInvitationFailed(value.model);
        break;
      }
    }).catchError((error){
      print(error);
    });
  }
}
