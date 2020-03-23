import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/InvitePeopleModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
import 'package:foodzi/StatusTrackviewTakeAway.dart/StatTrackTakeContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class StatTrackTakePresenter extends StatTrackTakeContractor {
  StatTrackTakeModelView statusTrackModelView;

  StatTrackTakePresenter(this.statusTrackModelView);
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
}
