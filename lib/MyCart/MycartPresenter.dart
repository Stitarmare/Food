import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/MyCart/MyCartContarctor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class MycartPresenter extends MyCartContarctor {
  MyCartModelView _cartModelView;
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
          _cartModelView.getCartMenuListsuccess(value.model.data);
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
  void removeItemfromCart(int cartId, int userId, BuildContext context) {
    ApiBaseHelper().post<ErrorModel>(UrlConstant.removeItemfromCartApi, context,
        body: {'cart_id': cartId, 'user_id': userId}).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Removed Item success");
          print(value.model);
          _cartModelView.removeItemSuccess();
          break;
        case SuccessType.failed:
          print("Removed Item failed");
          _cartModelView.removeItemFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
