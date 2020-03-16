import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
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
      "order_id": orderId,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Order status success");
          print(value.model);
          statusTrackModelView.getOrderStatussuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Order status failed");
          statusTrackModelView.getOrderStatusfailed();
          break;
      }
      // if (value['status_code'] == 200) {
      //   mregisterView.registerSuccess();
      // } else {
      //   mregisterView.registerfailed(value['message']);
      // }
    }).catchError((error) {
      print(error);
    });
//ApiCall
    //;
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }

  @override
  void getInvitedPeople(
      int orderId, int userId, int tableId, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.getInvitedPeople, context,
        body: {
          "order_id": orderId,
          "user_id": userId,
          "table_id": tableId
        }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Get Invited People success");
          print(value.model);
          statusTrackModelView.getInvitedPeopleSuccess();
          break;
        case SuccessType.failed:
          print("Get Invited People failed");
          statusTrackModelView.getInvitedPeopleFailed();
          break;
      }
      // if (value['status_code'] == 200) {
      //   mregisterView.registerSuccess();
      // } else {
      //   mregisterView.registerfailed(value['message']);
      // }
    }).catchError((error) {
      print(error);
    });
  }
}
