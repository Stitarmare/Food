import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantTAContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class RestaurantTAPresenter extends RestaurantTAContractor {
  RestaurantTAModelView restaurantView;
  RestaurantTAPresenter(RestaurantTAModelView restaurantModelView) {
    this.restaurantView = restaurantModelView;
  }

  @override
  void getMenuList(int restId, BuildContext context,
      {String menu, int category_id}) {
    // TODO: implement getMenuList
    ApiBaseHelper().post<RestaurantItemsModel>(
        UrlConstant.getMenuListApi, context, body: {
      "rest_id": restId,
      "category_id": category_id,
      "menu_type": menu
    }).then((value) {
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

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }
}
