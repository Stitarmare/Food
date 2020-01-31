import 'package:flutter/material.dart';
// <<<<<<< HEAD
import 'package:foodzi/Models/GetRestaurantReview.dart';

import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';
// import 'package:foodzi/models/GetRestaurantReview.dart';
// import 'package:foodzi/models/RestaurantInfoModel.dart';
// import 'package:foodzi/models/WriteRestaurantReview.dart';
//import 'package:foodzi/models/RestaurantInfoModel.dart';


// import 'package:foodzi/models/GetRestaurantReview.dart';
// import 'package:foodzi/Models/RestaurantInfoModel.dart';
// import 'package:foodzi/models/WriteRestaurantReview.dart';

// import 'package:foodzi/Models/RestaurantInfoModel.dart';
// import 'package:foodzi/models/RestaurantInfoModel.dart';
// =======
import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/GetRestaurantReview.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';
//import 'package:foodzi/models/RestaurantInfoModel.dart';

import 'package:foodzi/Models/GetRestaurantReview.dart';
import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';

import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';
//import 'package:foodzi/models/RestaurantInfoModel.dart';
// >>>>>>> cd7b8e32b8188472b5ae79dba5e7fd3e7dee4e60

abstract class RestaurantInfoContractor {
  void getRestaurantInfoPage(BuildContext context, int rest_id);
  void getRestaurantReview(BuildContext context, int rest_id);
  void writeRestaurantReview(
      BuildContext context, int rest_id, String description, int rating);
  void onBackPresed();
}

abstract class RestaurantInfoModelView{
  void restaurantInfoSuccess(RestaurantInfoData restInfoData);
  void getReviewSuccess(RestaurantReviewData getReviewList);
  void writeReviewSuccess(WriteRestaurantReviewModel writeReview);
  void restaurantInfoFailed();
  void getReviewFailed();
  void writeReviewFailed();
}
