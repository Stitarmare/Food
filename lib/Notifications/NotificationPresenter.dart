import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/NotificationModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Notifications/NotificationContarctor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class NotificationPresenter extends NotoficationContractor {
  NotificationPresenter({this.notificationModelView});
  NotificationModelView notificationModelView;

  @override
  void onBackPresed() {}

  @override
  void getNotifications(BuildContext context) {
    ApiBaseHelper()
        .get<GetNotificationListModel>(
      UrlConstant.getNotificationApi,
      context,
    )
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          notificationModelView.getNotificationsSuccess(value.model.data);
          break;
        case SuccessType.failed:
          notificationModelView.getNotificationsFailed();
          break;
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void acceptInvitation(
      int fromId, int invitationId, String status, BuildContext context) {
    ApiBaseHelper()
        .post<ErrorModel>(UrlConstant.acceptInvitationApi, context, body: {
      JSON_STR_FORM_ID: fromId,
      JSON_STR_INVITATION_ID: invitationId,
      JSON_STR_STATUS: status,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          notificationModelView.acceptInvitationSuccess(value.model);
          break;
        case SuccessType.failed:
          notificationModelView.acceptInvitationFailed(value.model);
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void updateNotification(BuildContext context) {
    ApiBaseHelper()
        .get<ErrorModel>(UrlConstant.updateNotificationApi, context)
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          notificationModelView.updateNotificationSuccess(value.model.message);
          break;
        case SuccessType.failed:
          notificationModelView.updateNotificationFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void acceptRequestInvitiation(
      int fromId, int invitationId, String status, BuildContext context) {
    ApiBaseHelper()
        .post<ErrorModel>(UrlConstant.acceptRejectRequestApi, context, body: {
      JSON_STR_FORM_ID: fromId,
      JSON_STR_INVITATION_ID: invitationId,
      JSON_STR_STATUS: status,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          notificationModelView.acceptRejectSuccess(value.model);
          break;
        case SuccessType.failed:
          notificationModelView.acceptRejectFailed(value.model);
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
