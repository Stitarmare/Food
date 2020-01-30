import 'package:foodzi/models/RestaurantInfoModel.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:foodzi/network/api_model.dart';

class RestaurantInfoPresenter extends RestaurantInfoContractor {
  RestaurantInfoPresenter({this.restaurantInfoModelView});
  RestaurantInfoModelView restaurantInfoModelView;
  @override
  void getRestaurantInfoPage(BuildContext context, int rest_id) {
    ApiBaseHelper().post<RestaurantInfoModel>(
        UrlConstant.restaurantInfo, context,
        body: {"rest_id": rest_id}).then((value) {
          print(value);
          switch(value.result){
            case SuccessType.success:
             print("Restaurant success");
          print(value.model);
           restaurantInfoModelView.restaurantInfoSuccess(value.model.data);
            break;
            case SuccessType.failed:
             print("Restaurant failed");
             restaurantInfoModelView.restaurantInfoFailed();
            break;
          }
        }).catchError((onError){
          print(onError);
        });

    // TODO: implement getRestaurantInfoPage
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }
}
