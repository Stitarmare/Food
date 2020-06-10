import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDownContractor.dart';
import 'package:foodzi/Models/CategoryListModel.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class MenuDropdpwnPresenter extends MenuDropdownContractor {
  MenuDropdownModelView menudropdownView;
  MenuDropdpwnPresenter(MenuDropdownModelView menudropdownModelView) {
    this.menudropdownView = menudropdownModelView;
  }

  @override
  void onBackPresed() {}

  @override
  void getMenuLCategory(int restId, BuildContext context, bool val) {
    ApiBaseHelper().post<CategoryListModel>(
        UrlConstant.getCategoryList, context,
        body: {JSON_STR_REST_ID: restId}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          menudropdownView.getMenuLCategorysuccess(value.model.data);
          break;
        case SuccessType.failed:
          menudropdownView.getMenuLCategoryfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
