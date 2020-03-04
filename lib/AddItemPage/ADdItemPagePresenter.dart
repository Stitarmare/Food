import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPage/AddItemPageContractor.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';
import 'package:foodzi/Models/GetTableListModel.dart';
import 'package:foodzi/Models/UpdateOrderModel.dart';
import 'package:foodzi/Models/UpdateOrderResponseModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class AddItemPagepresenter extends AddItemPageContractor {
  GetTableListModelView getTableListModel;

  AddTablenoModelView addTablenoModelView;

  AddItemPageModelView addItemPageModelView;

  AddmenuToCartModelview addMenuToCartModel;

  ClearCartModelView clearCartModelView;
  UpdateCartModelView updateCartModelView;

  AddItemPagepresenter(
    AddItemPageModelView addItemPageView,
    AddmenuToCartModelview addMenuToCartModel,
    AddTablenoModelView addTablenoModelView,
    GetTableListModelView getTableListModel,
    ClearCartModelView clearCartModelView,
    UpdateCartModelView updateCartModelView,
  ) {
    this.addItemPageModelView = addItemPageView;
    this.addMenuToCartModel = addMenuToCartModel;
    this.addTablenoModelView = addTablenoModelView;
    this.getTableListModel = getTableListModel;
    this.clearCartModelView = clearCartModelView;
    this.updateCartModelView = updateCartModelView;
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

  @override
  void getTableListno(int rest_id, BuildContext context) {
    ApiBaseHelper()
        .post<GetTableListModel>(UrlConstant.getTablenoListApi, context, body: {
      "rest_id": rest_id,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          getTableListModel.getTableListSuccess(value.model.data);
          print("success");
          break;
        case SuccessType.failed:
          getTableListModel.getTableListFailed();
          print("failed");
          break;
      }
    }).catchError((error) {
      print(error);
    });
//ApiCall
    //;
  }

  @override
  void performaddMenuToCart(AddItemsToCartModel item, BuildContext context) {
    ApiBaseHelper()
        .post<AddMenuToCartModel>(UrlConstant.addMenuToCartApi, context,
            body: item.toJson())
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          addMenuToCartModel.addMenuToCartsuccess();
          print("success");
          break;
        case SuccessType.failed:
          addMenuToCartModel.addMenuToCartfailed();
          print("failed");
          break;
      }
    }).catchError((error) {
      print(error);
    });
//ApiCall
    //;
  }

  @override
  void addTablenoToCart(
      int user_id, int rest_id, int table_id, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.addTablenoApi, context, body: {
      "user_id": user_id,
      "table_id": table_id,
      "rest_id": rest_id,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          addTablenoModelView.addTablebnoSuccces();
          print("success");
          break;
        case SuccessType.failed:
          addTablenoModelView.addTablenofailed();
          print("failed");
          break;
      }
    }).catchError((error) {
      print(error);
    });
//ApiCall
    //;
  }

  @override
  void clearCart(BuildContext context) {
    // TODO: implement getNotifications
    ApiBaseHelper()
        .get<ErrorModel>(
      UrlConstant.clearCartApi,
      context,
    )
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Clear cart success");
          print(value.model);
          clearCartModelView.clearCartSuccess();
          break;
        case SuccessType.failed:
          print("Clear cart failed");
          clearCartModelView.clearCartFailed();
          break;
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void updateOrder(UpdateOrderModel updateOrderModel, BuildContext context) {
    ApiBaseHelper()
        .post<UpdateOrderResponseModel>(UrlConstant.updateOrderApi, context, body: updateOrderModel.toJson()).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          updateCartModelView.updateOrderSuccess();
          print("success");
          break;
        case SuccessType.failed:
          updateCartModelView.updateOrderFailed();
          print("failed");
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
