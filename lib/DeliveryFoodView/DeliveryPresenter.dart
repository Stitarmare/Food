import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/DeliveryFoodView/DeliveryContractor.dart';
import 'package:foodzi/DineInPage/DineInContractor.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class DineInDeliveryPresenter extends DineInDeliveryContractor {
  DineInDeliveryModelView restaurantModelView;

  DineInDeliveryPresenter(this.restaurantModelView);
  @override
  void getrestaurantspage(
      String latitude,
      String longitude,
      String rating,
      String favourite,
      String sortByDistance,
      String sortByRating,
      int page,
      int delivery,
      BuildContext context) {
    var body = {
      JSON_STR_LATI: latitude,
      JSON_STR_LONG: longitude,
      JSON_STR_PAGE: page,
      JSON_STR_DELIVERY: delivery
    };
    if (rating != null) {
      body["rating"] = rating;
    }
    if (favourite != null) {
      body["favourite"] = favourite;
    }
    if (sortByDistance != null) {
      body["sort_by_distance"] = sortByDistance;
    }
    if (sortByRating != null) {
      body["sort_by_rating"] = sortByRating;
    }

    ApiBaseHelper()
        .post<RestaurantListModel>(UrlConstant.restaurantListApi, context,
            body: body)
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          restaurantModelView.restaurantsuccess(value.model.data);
          break;
        case SuccessType.failed:
          restaurantModelView.restaurantfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void onBackPresed() {}
}
