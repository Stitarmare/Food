
// import 'package:flutter/material.dart';
// import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayContractor.dart';
// import 'package:foodzi/network/ApiBaseHelper.dart';
// import 'package:foodzi/network/api_model.dart';
// import 'package:foodzi/network/url_constant.dart';

// class PaymentTipAndPayPresenter extends PaymentTipAndPayContarctor {
//   PaymentTipAndPayModelView _paymentTipAndPayModelView;
//   PaymentTipAndPayPresenter(PaymentTipAndPayModelView _paymentTipAndPayModelView) {
//     this._paymentTipAndPayModelView = _paymentTipAndPayModelView;
//   }

//   @override
//   void onBackPresed() {
//     // TODO: implement onBackPresed
//   }

//   @override
//   void placeOrder(int restId, int userId,String orderType, int tableId,List items,double totalAmount,BuildContext context,) {
//     // TODO: implement getMenuList
//     ApiBaseHelper()
//         .post<>(UrlConstant., context, body: {
//       "user_id": userId,
//       "rest_id": restId, 
//     }).then((value) {
//       print(value);
//       switch (value.result) {
//         case SuccessType.success:
//           print("Added Menu To Cart success");
//           print(value.model);
//           _paymentTipAndPayModelView.placeOrdersuccess(value.model.data);
//           break;
//         case SuccessType.failed:
//           print("Added Menu To Cart failed");
//           _paymentTipAndPayModelView.placeOrderfailed();
//           break;
//       }
//     }).catchError((error) {
//       print(error);
//     });
//   }


// }