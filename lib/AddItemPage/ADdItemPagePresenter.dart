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
  void performAddItem(int itemId, int restId, BuildContext context) {
    ApiBaseHelper().post<AddItemPageModelList>(
        UrlConstant.getmenudetailsApi, context,
        body: {
          "item_id": itemId,
          "rest_id": restId,
        }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("AddItem success");
          print(value.model);
          addItemPageModelView.addItemsuccess(value.model.data, value.model);
          break;
        case SuccessType.failed:
          print("AddItem failed");
          addItemPageModelView.addItemfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void getTableListno(int restId, BuildContext context) {
    ApiBaseHelper()
        .post<GetTableListModel>(UrlConstant.getTablenoListApi, context, body: {
      "rest_id": restId,
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
      int userId, int restId, int tableId, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.addTablenoApi, context, body: {
      "user_id": userId,
      "table_id": tableId,
      "rest_id": restId,
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
  }

  @override
  void clearCart(BuildContext context) {
    ApiBaseHelper()
        .get<ErrorModel>(
      UrlConstant.clearCartApi,
      context,
    )
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          clearCartModelView.clearCartSuccess();
          break;
        case SuccessType.failed:
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
        .post<UpdateOrderResponseModel>(UrlConstant.updateOrderApi, context,
            body: updateOrderModel.toJson())
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          updateCartModelView.updateOrderSuccess();
          break;
        case SuccessType.failed:
          updateCartModelView.updateOrderFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
