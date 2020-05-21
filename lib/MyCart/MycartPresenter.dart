import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetTableListModel.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/MyCart/MyCartContarctor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class MycartPresenter extends MyCartContarctor {
  MyCartModelView _cartModelView;
  GetTableListModelView getTableListModel;

  AddTablenoModelView addTablenoModelView;

  MycartPresenter(
      MyCartModelView _cartModelView,
      GetTableListModelView getTableListModel,
      AddTablenoModelView addTablenoModelView) {
    this._cartModelView = _cartModelView;
    this.getTableListModel = getTableListModel;
    this.addTablenoModelView = addTablenoModelView;
  }

  @override
  void onBackPresed() {}

  @override
  void getCartMenuList(
    int restId,
    BuildContext context,
    int userId,
  ) {
    ApiBaseHelper().post<MenuCartDisplayModel>(
        UrlConstant.getCartDetailsApi, context,
        body: {
          JSON_STR_USER_ID: userId,
          JSON_STR_REST_ID: restId,
        },isShowDialoag: true).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          _cartModelView.getCartMenuListsuccess(value.model.data, value.model);
          break;
        case SuccessType.failed:
          _cartModelView.getCartMenuListfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void removeItemfromCart(int cartId, int userId, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.removeItemfromCartApi, context,
        body: {
          JSON_STR_CART_ID: cartId,
          JSON_STR_USER_ID: userId
        }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          _cartModelView.removeItemSuccess();
          break;
        case SuccessType.failed:
          _cartModelView.removeItemFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  void addTablenoToCart(
      int userId, int restId, int tableId, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.addTablenoApi, context, body: {
      JSON_STR_USER_ID: userId,
      JSON_STR_TABLE_ID: tableId,
      JSON_STR_REST_ID: restId,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          addTablenoModelView.addTablebnoSuccces();
          break;
        case SuccessType.failed:
          addTablenoModelView.addTablenofailed();
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
      JSON_STR_REST_ID: restId,
    },isShowDialoag: true).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          getTableListModel.getTableListSuccess(value.model.data);
          break;
        case SuccessType.failed:
          getTableListModel.getTableListFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void updateQauntityCount(
      int cartId, int quantity, double amount, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.updatequantityApi, context,
        body: {
          JSON_STR_CART_ID: cartId,
          JSON_STR_QUANTITY: quantity,
          JSON_STR_AMOUNT: amount
        }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          _cartModelView.updatequantitySuccess();
          break;
        case SuccessType.failed:
          _cartModelView.updatequantityfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
