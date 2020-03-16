import 'package:flutter/material.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineViewContractor.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class ConfirmationDineviewPresenter extends ConfirmationDineViewContractor {
  ConfirmationDineViewModelView _confirmationDineViewModelView;

  ConfirmationDineviewPresenter(
      ConfirmationDineViewModelView _confirmationDineViewModelView) {
    this._confirmationDineViewModelView = _confirmationDineViewModelView;
  }
  @override
  void onBackPresed() {}
  @override
  void addPeople(String mobile_number, int table_id, int rest_id, int order_id,
      BuildContext context) {
    ApiBaseHelper()
        .post<ErrorModel>(UrlConstant.addPeopleToOrderApi, context, body: {
      "mobile_number": mobile_number,
      "table_id": table_id,
      "rest_id": rest_id,
      "order_id": order_id
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Add People Success");
          print(value.model);
          _confirmationDineViewModelView.addPeopleSuccess();
          break;
        case SuccessType.failed:
          print("Add People Failed");
          _confirmationDineViewModelView.addPeopleFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
    // TODO: implement addPeople
  }

  @override
  void getPeopleList(BuildContext context) {
    ApiBaseHelper()
        .get<GetPeopleListModel>(UrlConstant.getPeopleListApi, context)
        .then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model.statusCode);
          _confirmationDineViewModelView
              .getPeopleListonSuccess(value.model.data);
          break;
        case SuccessType.failed:
          _confirmationDineViewModelView.getPeopleListonFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}