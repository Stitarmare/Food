



import 'package:flutter/material.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

abstract class NotificationSettingContractor {
  void onSuccessUpdateNotification();
  void onFailedUpdateNotification();
}

class NotificationSettingPresenter {

    NotificationSettingContractor notificationSettingContractor;
    NotificationSettingPresenter({this.notificationSettingContractor});
    void callUpdateNotiApi(List<int> notiValue,BuildContext context) async{
      var responce = await ApiBaseHelper().post<ErrorModel>(UrlConstant.updateNotificationSetting, context,body: {
        "user_id":Globle().loginModel.data.id,
        "setting":notiValue
      });

      switch (responce.result) {

        case SuccessType.success:
        notificationSettingContractor.onSuccessUpdateNotification();
          // TODO: Handle this case.
          break;
        case SuccessType.failed:
        notificationSettingContractor.onFailedUpdateNotification();
          // TODO: Handle this case.
          break;
      }

    }
}