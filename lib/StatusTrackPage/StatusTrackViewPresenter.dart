import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/InvitePeopleModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class StatusTrackViewPresenter extends StatusTrackViewContractor {
  StatusTrackViewModelView statusTrackModelView;

  StatusTrackViewPresenter(this.statusTrackModelView);
  @override
  void getOrderStatus(int orderId, BuildContext context) {
    ApiBaseHelper()
        .post<OrderStatusModel>(UrlConstant.getOrderStatusApi, context, body: {
      JSON_STR_ORDER_ID: orderId,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          statusTrackModelView.getOrderStatussuccess(value.model.data);
          break;
        case SuccessType.failed:
          statusTrackModelView.getOrderStatusfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void onBackPresed() {}

  @override
  void getInvitedPeople(int userId, int tableId, BuildContext context,
      {int orderId}) {
    ApiBaseHelper().post<InvitePeopleModel>(
        UrlConstant.getInvitedPeople, context, body: {
      JSON_STR_ORDER_ID: orderId,
      JSON_STR_USER_ID: userId,
      JSON_STR_TABLE_ID: tableId
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          statusTrackModelView.getInvitedPeopleSuccess(value.model.data);
          break;
        case SuccessType.failed:
          statusTrackModelView.getInvitedPeopleFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
