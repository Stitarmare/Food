import 'package:flutter/material.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/PayCheckOutNetBanking.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Models/payment_Checkout_model.dart';
import 'package:foodzi/MyOrders/MyOrderContractor.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayContractor.dart';
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
      "order_id": orderid,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Order Detail success");
          print(value.model);
          _paymentTipandPayDiModelView.getOrderDetailsSuccess(value.model.data);
          break;
        case SuccessType.failed:
          print("Order Detail failed");
          _paymentTipandPayDiModelView.getOrderDetailsFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
    // TODO: implement getOrderDetails
  }

  @override
  void onBackPresed() {
    // TODO: implement onBackPresed
  }

  @override
  void getCheckoutDetails(String checkoutId, BuildContext context) {
    ApiBaseHelper().post<PaymentCheckoutModel>(
        UrlConstant.checkoutPaymentStatus, context,
        body: {"encrypted_checkout_id": checkoutId}).then((value) {
      switch (value.result) {
        case SuccessType.success:
          print("Order Detail success");
          print(value.model);
          _paymentTipandPayDiModelView.paymentCheckoutSuccess(value.model);
          break;
        case SuccessType.failed:
          print("Order Detail failed");
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
    int order_id,
    String payment_mode,
    int amount,
    int total_amount,
    String transacionId,
    BuildContext context, [
    int tip,
  ]) {
    ApiBaseHelper()
        .post<ErrorModel>(UrlConstant.getFinalBillApi, context, body: {
      "user_id": userId,
      "rest_id": restId,
      "order_id": order_id,
      "payment_mode": payment_mode,
      "amount": amount,
      "tip": tip,
      "total_amount": total_amount,
      "transaction_id": transacionId,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Place Order success.");
          print(value.model);
          _payModelView.payfinalBillSuccess();
          break;
        case SuccessType.failed:
          print("Place Order failed.");
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
    // String currency,
    double amount,
    BuildContext context,
  ) {
    ApiBaseHelper().post<PaycheckoutNetbanking>(
        UrlConstant.paycheckOutNetbankingApi, context,
        body: {
          "rest_id": restId,
          //"currency": currency,
          "amount": amount,
        }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Place Order success.");
          print(value.model);
          _paybillcheckoutModelView.payBillCheckoutSuccess(value.model);
          break;
        case SuccessType.failed:
          print("Place Order failed.");
          _paybillcheckoutModelView.payBillCheckoutFailed();
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
