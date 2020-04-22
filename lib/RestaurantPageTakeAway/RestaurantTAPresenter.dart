import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantTAContractor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
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
      {String menu, int categoryId}) {
    ApiBaseHelper()
        .post<RestaurantItemsModel>(UrlConstant.getMenuListApi, context, body: {
      JSON_STR_REST_ID: restId,
      JSON_STR_CATEGORY_ID: categoryId,
      JSON_STR_MENU_TYPE: menu
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          Globle().currencySymb = value.model.currencySymbol;
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
  void onBackPresed() {}
}
