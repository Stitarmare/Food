import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/RestaurantPage/RestaurantContractor.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantTAContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class RestaurantTAPresenter extends RestaurantTAContractor {
  RestaurantTAPresenter(_restaurantViewState, {this.restaurantModelView});
  RestaurantTAModelView restaurantModelView;
  @override
  void getrestaurantspage(String latitude, String longitude, String sort_by,
      String search_by, int page, BuildContext context) {
    ApiBaseHelper().post<RestaurantListModel>(
        UrlConstant.restaurantListApi, context,
        body: {
          "latitude": latitude,
          "longitude": longitude,
          "sort_by": sort_by,
          "search_by": search_by,
          "page": page
        }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Restaurant success");
          print(value.model);
          restaurantModelView.restaurantsuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Restaurant failed");
          restaurantModelView.restaurantfailed();
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
