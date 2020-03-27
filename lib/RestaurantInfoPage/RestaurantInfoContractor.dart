import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetRestaurantReview.dart';
import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';

abstract class RestaurantInfoContractor {
  void getRestaurantInfoPage(BuildContext context, int restId);
  void getRestaurantReview(BuildContext context, int restId);
  void writeRestaurantReview(
      BuildContext context, int restId, String description, int rating);
  void onBackPresed();
}

abstract class RestaurantInfoModelView {
  void restaurantInfoSuccess(RestaurantInfoData restInfoData);
  void getReviewSuccess(List<RestaurantReviewList> getReviewList);
  void writeReviewSuccess(WriteRestaurantReviewModel writeReview);
  void restaurantInfoFailed();
  void getReviewFailed();
  void writeReviewFailed();
}
