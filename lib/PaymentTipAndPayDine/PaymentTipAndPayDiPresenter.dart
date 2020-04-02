import 'package:flutter/material.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/PayCheckOutNetBanking.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Models/payment_Checkout_model.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayContractor.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

class PaymentTipandPayDiPresenter extends PaymentTipandPayDiContractor {
  PaymentTipandPayDiModelView _paymentTipandPayDiModelView;
  PaymentTipandPayDiPresenter(
      PaymentTipandPayDiModelView _paymentTipandPayDiModelView) {
    this._paymentTipandPayDiModelView = _paymentTipandPayDiModelView;
  }

  @override
  void getOrderDetails(int orderid, BuildContext context) {
    ApiBaseHelper()
        .post<OrderDetailsModel>(UrlConstant.getorderDetails, context, body: {
      JSON_STR_ORDER_ID: orderid,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          _paymentTipandPayDiModelView.getOrderDetailsSuccess(value.model.data,value.model);
          break;
        case SuccessType.failed:
          _paymentTipandPayDiModelView.getOrderDetailsFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void onBackPresed() {}

  @override
  void getCheckoutDetails(String checkoutId, BuildContext context) {
    ApiBaseHelper().post<PaymentCheckoutModel>(
        UrlConstant.checkoutPaymentStatus, context,
        body: {JSON_STR_ENCRYPTED_CODE: checkoutId}).then((value) {
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          _paymentTipandPayDiModelView.paymentCheckoutSuccess(value.model);
          break;
        case SuccessType.failed:
          _paymentTipandPayDiModelView.paymentCheckoutFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}

class PayFinalBillPresenter extends PayFinalBillContaractor {
  PayFinalBillModelView _payModelView;
  PayFinalBillPresenter(PayFinalBillModelView _payModelView) {
    this._payModelView = _payModelView;
  }

  @override
  void payfinalOrderBill(
    int userId,
    int restId,
    int orderId,
    String paymentMode,
    int amount,
    int totalAmount,
    String transacionId,
    BuildContext context, [
    int tip,
  ]) {
    ApiBaseHelper()
        .post<ErrorModel>(UrlConstant.getFinalBillApi, context, body: {
      JSON_STR_USER_ID: userId,
      JSON_STR_REST_ID: restId,
      JSON_STR_ORDER_ID: orderId,
      JSON_STR_PAYMENT_MODE: paymentMode,
      JSON_STR_AMOUNT: amount,
      JSON_STR_TIP: tip,
      JSON_STR_TOTAL_AMOUNT: totalAmount,
      JSON_STR_TRANSACTION_ID: transacionId,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          _payModelView.payfinalBillSuccess();
          break;
        case SuccessType.failed:
          _payModelView.payfinalBillFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}

class PayBillCheckoutPresenter extends PayBillCheckoutContaractor {
  PayBillCheckoutModelView _paybillcheckoutModelView;
  PayBillCheckoutPresenter(PayBillCheckoutModelView _paybillcheckoutModelView) {
    this._paybillcheckoutModelView = _paybillcheckoutModelView;
  }

  @override
  void payBillCheckOut(
    int restId,
    int amount,
    BuildContext context,
  ) {
    ApiBaseHelper().post<PaycheckoutNetbanking>(
        UrlConstant.paycheckOutNetbankingApi, context,
        body: {
          JSON_STR_REST_ID: restId,
          JSON_STR_AMOUNT: amount,
        }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print(value.model);
          _paybillcheckoutModelView.payBillCheckoutSuccess(value.model);
          break;
        case SuccessType.failed:
          _paybillcheckoutModelView.payBillCheckoutFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
