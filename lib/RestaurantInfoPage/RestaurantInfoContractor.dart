import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:foodzi/models/GetRestaurantReview.dart';
import 'package:foodzi/models/RestaurantInfoModel.dart';
import 'package:foodzi/models/WriteRestaurantReview.dart';
=======
import 'package:foodzi/Models/RestaurantInfoModel.dart';
//import 'package:foodzi/models/RestaurantInfoModel.dart';
>>>>>>> 728988086e94a6588f16be72735050100a0e6b98

abstract class RestaurantInfoContractor{
void getRestaurantInfoPage( BuildContext context,int rest_id);
void getRestaurantReview(BuildContext context,int rest_id);
void writeRestaurantReview(BuildContext context,int rest_id,String description, int rating );
void onBackPresed();
}

abstract class RestaurantInfoModelView{
  void restaurantInfoSuccess(RestaurantInfoData restInfoList);
  void getReviewSuccess(GetRestaurantReviewModel getReviewList);
  void writeReviewSuccess(WriteRestaurantReviewModel writeReview);
  void restaurantInfoFailed();
  void getReviewFailed();
  void writeReviewFailed();
}