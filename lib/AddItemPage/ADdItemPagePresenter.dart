import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPage/AddItemPageContractor.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class AddItemPagepresenter extends AddItemPageContractor {
  @override
  void onBackPresed() {}
  AddItemPageModelView addItemPageModelView;
  AddItemPagepresenter(this.addItemPageModelView);

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
