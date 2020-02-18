import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDownContractor.dart';
import 'package:foodzi/Models/CategoryListModel.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/RestaurantPage/RestaurantContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class MenuDropdpwnPresenter extends MenuDropdownContractor {
  MenuDropdownModelView menudropdownView;
  MenuDropdpwnPresenter(MenuDropdownModelView menudropdownModelView) {
    this.menudropdownView = menudropdownModelView;
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }

  @override
  void getMenuLCategory(int restId, BuildContext context) {
    // TODO: implement getMenuList
    ApiBaseHelper().post<CategoryListModel>(
        UrlConstant.getCategoryList, context,
        body: {"rest_id": restId}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Category get Menu success");
          print(value.model);
          menudropdownView.getMenuLCategorysuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Category get Menu failed");
          menudropdownView.getMenuLCategoryfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
