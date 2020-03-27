import 'package:flutter/src/widgets/framework.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/MyCartTW/MyCartTWContractor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class MycartTWPresenter extends MyCartTWContarctor {
  MyCartTWModelView _cartModelView;

  MycartTWPresenter(MyCartTWModelView _cartModelView) {
    this._cartModelView = _cartModelView;
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
        }).then((value) {
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
}
