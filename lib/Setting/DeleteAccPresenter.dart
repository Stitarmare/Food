import 'package:flutter/material.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Setting/DeleteAccContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class DeleteAccPresenter extends DeleteAccContractor {
  DeleteAccModelView deleteAccModelView;

  DeleteAccPresenter(DeleteAccModelView mView) {
    this.deleteAccModelView = mView;
  }
  @override
  void deleteAccRequest(BuildContext context) {
    ApiBaseHelper()
        .get<ErrorModel>(UrlConstant.deleteAccountAPI, context)
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          deleteAccModelView.deleteAccSuccess(value.model.message);
          break;
        case SuccessType.failed:
          print(value.model);
          deleteAccModelView.deleteAccFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
