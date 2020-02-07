import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/RestaurantPage/RestaurantContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class RestaurantPresenter extends RestaurantContractor {
  RestaurantModelView restaurantView;
  RestaurantPresenter(RestaurantModelView restaurantModelView) {
    this.restaurantView = restaurantModelView;
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }

  @override
  void getMenuList(int restId,BuildContext context,{String menu}) {
    // TODO: implement getMenuList
    ApiBaseHelper().post<RestaurantItemsModel>(
        UrlConstant.getMenuListApi, context,
        body: {"rest_id": restId, "menu_type": menu}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Restaurant get Menu success");
          print(value.model);
          restaurantView.getMenuListsuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Restaurant get Menu failed");
          restaurantView.getMenuListfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
