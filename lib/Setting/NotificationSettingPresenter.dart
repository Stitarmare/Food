import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetNotificationSetting.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

abstract class NotificationSettingContractor {
  void onSuccessUpdateNotification();
  void onFailedUpdateNotification();
  void onSuccessGetNotification(GetNotificationSetting getNotificationSetting);
  void onFailedGetNotification();
}

class NotificationSettingPresenter {
  NotificationSettingContractor notificationSettingContractor;
  NotificationSettingPresenter({this.notificationSettingContractor});
  void callUpdateNotiApi(List<int> notiValue, BuildContext context) async {
    var responce = await ApiBaseHelper().post<ErrorModel>(
        UrlConstant.updateNotificationSetting, context,
        body: {"user_id": Globle().loginModel.data.id, "setting": notiValue});

    switch (responce.result) {
      case SuccessType.success:
        notificationSettingContractor.onSuccessUpdateNotification();
        break;
      case SuccessType.failed:
        notificationSettingContractor.onFailedUpdateNotification();
        break;
    }
  }

  void getNotificationSetting(BuildContext context) async {
    var responce = await ApiBaseHelper().get<GetNotificationSetting>(
        UrlConstant.getNotificationSetting, context);

    switch (responce.result) {
      case SuccessType.success:
        notificationSettingContractor.onSuccessGetNotification(responce.model);
        // TODO: Handle this case.
        break;
      case SuccessType.failed:
        notificationSettingContractor.onFailedGetNotification();
        // TODO: Handle this case.
        break;
    }
  }
}
