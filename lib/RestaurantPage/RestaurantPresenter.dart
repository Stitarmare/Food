import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/RestaurantPage/RestaurantContractor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class RestaurantPresenter extends RestaurantContractor {
  RestaurantModelView restaurantView;
  RestaurantPresenter(RestaurantModelView restaurantModelView) {
    this.restaurantView = restaurantModelView;
  }

  @override
  void onBackPresed() {}

  @override
  void getMenuList(int restId, BuildContext context,
      {String menu, int categoryId}) {
    ApiBaseHelper()
        .post<RestaurantItemsModel>(UrlConstant.getMenuListApi, context, body: {
      JSON_STR_REST_ID: restId,
      JSON_STR_MENU_TYPE: menu,
      JSON_STR_CATEGORY_ID: categoryId
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          Globle().currencySymb = value.model.currencyCode;
          Preference.setPersistData(Globle().currencySymb, STR_CURRENCY_SYMBOL);
          restaurantView.getMenuListsuccess(value.model.data, value.model);
          break;
        case SuccessType.failed:
          restaurantView.getMenuListfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void notifyWaiter(
      int userId, int tableId, String deviceToken, BuildContext context) {
    // TODO: implement notifyWaiter
    ApiBaseHelper().post<ErrorModel>(UrlConstant.buzzWaiter, context, body: {
      JSON_STR_USER_ID: userId,
      JSON_STR_TABLE_ID: tableId,
      JSON_STR_DEVICE_TOKEN: deviceToken
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          restaurantView.notifyWaiterSuccess();
          break;
        case SuccessType.failed:
          restaurantView.notifyWaiterFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
