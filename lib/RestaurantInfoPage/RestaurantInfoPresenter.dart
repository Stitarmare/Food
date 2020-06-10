import 'package:foodzi/Models/GetRestaurantReview.dart';
import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';

class RestaurantInfoPresenter extends RestaurantInfoContractor {
  RestaurantInfoPresenter({this.restaurantInfoModelView});
  RestaurantInfoModelView restaurantInfoModelView;
  @override
  void getRestaurantInfoPage(BuildContext context, int restId) {
    ApiBaseHelper().post<RestaurantInfoModel>(
        UrlConstant.restaurantInfo, context,
        body: {JSON_STR_REST_ID: restId}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          restaurantInfoModelView.restaurantInfoSuccess(value.model.data);
          break;
        case SuccessType.failed:
          restaurantInfoModelView.restaurantInfoFailed();
          break;
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void getRestaurantReview(BuildContext context, int restId, int page) {
    ApiBaseHelper().post<GetRestaurantReview>(UrlConstant.getReviewApi, context,
        body: {
          JSON_STR_REST_ID: restId,
          JSON_STR_REST_PAGE: page
        }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          restaurantInfoModelView.getReviewSuccess(value.model.data);
          break;
        case SuccessType.failed:
          restaurantInfoModelView.getReviewFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void writeRestaurantReview(
      BuildContext context, int restId, String description, int rating) {
    ApiBaseHelper().post<WriteRestaurantReviewModel>(
        UrlConstant.writeReviewApi, context, body: {
      JSON_STR_REST_ID: restId,
      JSON_STR_DESC: description,
      JSON_STR_RATING: rating
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          restaurantInfoModelView.writeReviewSuccess(value.model);
          break;
        case SuccessType.failed:
          restaurantInfoModelView.writeReviewFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void onBackPresed() {}
}
