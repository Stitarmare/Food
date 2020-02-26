import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';
import 'package:foodzi/Models/GetTableListModel.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/MyCart/MyCartContarctor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class MycartPresenter extends MyCartContarctor {
  MyCartModelView _cartModelView;
  GetTableListModelView getTableListModel;

  AddTablenoModelView addTablenoModelView;

  MycartPresenter(MyCartModelView _cartModelView) {
    this._cartModelView = _cartModelView;
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }

  @override
  void getCartMenuList(
    int restId,
    BuildContext context,
    int userId,
  ) {
    // TODO: implement getMenuList
    ApiBaseHelper().post<MenuCartDisplayModel>(
        UrlConstant.getCartDetailsApi, context,
        body: {
          "user_id": userId,
          "rest_id": restId,
        }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Added Menu To Cart success");
          print(value.model);
          _cartModelView.getCartMenuListsuccess(value.model.data, value.model);
          break;
        case SuccessType.failed:
          print("Added Menu To Cart failed");
          _cartModelView.getCartMenuListfailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
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
}
