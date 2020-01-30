import 'package:flutter/material.dart';
import 'package:foodzi/models/RestaurantInfoModel.dart';

abstract class RestaurantInfoContractor{
void getRestaurantInfoPage( BuildContext context,int rest_id);
void onBackPresed();
}

abstract class RestaurantInfoModelView{
  void restaurantInfoSuccess(List<RestaurantInfoData> restInfoList);
  void restaurantInfoFailed();
}