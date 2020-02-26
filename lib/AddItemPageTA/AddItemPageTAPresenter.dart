import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPageTA/AddItemPageTAContractor.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class AddItemPageTApresenter extends AddItemPageTAContractor {
  AddItemPageTAModelView addItemPageModelView;
<<<<<<< HEAD
  AddItemPageTApresenter(AddItemPageTAModelView addItemPageView) {
=======

  AddmenuToCartModelviews addMenuToCartModel;

  AddItemPageTApresenter(AddItemPageTAModelView addItemPageView,AddmenuToCartModelviews addMenuToCartModel) {
>>>>>>> 9ec3a5ed106d6b4ad8242e8cf3e9ded29c7b0bd8
    this.addItemPageModelView = addItemPageView;
    this.addMenuToCartModel = addMenuToCartModel;
  }

  @override
  void onBackPresed() {}

  @override
  void performAddItem(int item_id, int rest_id, BuildContext context) {
    ApiBaseHelper().post<AddItemPageModelList>(
        UrlConstant.getmenudetailsApi, context,
        body: {
          "item_id": item_id,
          "rest_id": rest_id,
        }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("AddItem success");
          print(value.model);
          addItemPageModelView.addItemsuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("AddItem failed");
          addItemPageModelView.addItemfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
//ApiCall
    //;
  }
}
