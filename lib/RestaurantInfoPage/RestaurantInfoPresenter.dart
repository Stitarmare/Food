// import 'package:foodzi/Models/RestaurantInfoModel.dart';
// import 'package:foodzi/models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/GetRestaurantReview.dart';
import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:foodzi/network/api_model.dart';
// import 'package:foodzi/models/GetRestaurantReview.dart';
// import 'package:foodzi/models/WriteRestaurantReview.dart';

class RestaurantInfoPresenter extends RestaurantInfoContractor {
  RestaurantInfoPresenter({this.restaurantInfoModelView});
  RestaurantInfoModelView restaurantInfoModelView;
  @override
  void getRestaurantInfoPage(BuildContext context, int rest_id) {
    ApiBaseHelper().post<RestaurantInfoModel>(
        UrlConstant.restaurantInfo, context,
        body: {"rest_id": rest_id}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Restaurant success");
          print(value.model);
          // restaurantInfoModelView.restaurantInfoSuccess(value.model);
          // restaurantInfoModelView.restaurantInfoSuccess(value.model.data);
          restaurantInfoModelView.restaurantInfoSuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Restaurant failed");
          restaurantInfoModelView.restaurantInfoFailed();
          break;
      }
    }).catchError((onError) {
      print(onError);
    });

    // TODO: implement getRestaurantInfoPage
  }

  @override
  void getRestaurantReview(BuildContext context, int rest_id) {
    // TODO: implement getRestaurantReview
    ApiBaseHelper().post<GetRestaurantReviewModel>(
        UrlConstant.getReviewApi, context,
        body: {"rest_id": rest_id}).then((value) {
          print(value);
            switch (value.result) {
        case SuccessType.success:
          print("Restaurant success");
          print(value.model);
          restaurantInfoModelView.getReviewSuccess(value.model);
          // restaurantInfoModelView.restaurantInfoSuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Restaurant failed");
          restaurantInfoModelView.restaurantInfoFailed();
          break;
      }
        }).catchError((error){
          print(error);
        });
  }

  @override
  void writeRestaurantReview(
      BuildContext context, int rest_id, String description, int rating) {
    // TODO: implement writeRestaurantReview
     ApiBaseHelper().post<WriteRestaurantReviewModel>(
        UrlConstant.writeReviewApi, context,
        body: {"rest_id": rest_id,
        "description":description,
        "rating":rating
        }).then((value) {
          print(value);
            switch (value.result) {
        case SuccessType.success:
          print("Restaurant review success");
          print(value.model);
          restaurantInfoModelView.writeReviewSuccess(value.model);
          // restaurantInfoModelView.restaurantInfoSuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Restaurant failed");
          restaurantInfoModelView.restaurantInfoFailed();
          break;
      }
        }).catchError((error){
          print(error);
        });
  }
  
  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }
}
