import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/StatusTrackviewTakeAway.dart/StatTrackTakeContractor.dart';
import 'package:foodzi/Utils/String.dart';
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
}
