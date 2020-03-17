import 'package:foodzi/Models/AddItemPageModel.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';
import 'package:foodzi/Models/CategoryListModel.dart';
import 'package:foodzi/Models/CurrentOrderModel.dart';
import 'package:foodzi/Models/EditCityModel.dart';
import 'package:foodzi/Models/EditCountryModel.dart';
import 'package:foodzi/Models/EditStateModel.dart';
import 'package:foodzi/Models/GetMyOrdersBookingHistory.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';
import 'package:foodzi/Models/GetRestaurantReview.dart';
import 'package:foodzi/Models/GetTableListModel.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/NotificationModel.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/Models/Otpverify.dart';
import 'package:foodzi/Models/PayCheckOutNetBanking.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';
import 'package:foodzi/Models/Resendotp.dart';
import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';
import 'package:foodzi/Models/loginmodel.dart';
import 'package:foodzi/Models/payment_Checkout_model.dart';
import 'package:foodzi/Models/registermodel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Models/loginwithotp.dart';
import 'package:foodzi/Models/UpdateprofileModel.dart';

//import 'package:foodzi/models/RestaurantInfoModel.dart';

import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/GetRestaurantReview.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';

//import 'package:foodzi/models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/resetpwdwithotp.dart';

enum SuccessType { success, failed }

class APIModel<T> {
  var result = SuccessType.failed;
  T model;
}

class GenericModel<T> {
  static T fromJson<T>(dynamic json) {
    switch (T) {
      case LoginModel:
        return LoginModel.fromJson(json) as T;

      case Registermodel:
        return Registermodel.fromJson(json) as T;

      case LoginWithOtpModel:
        return LoginWithOtpModel.fromJson(json) as T;

      case OtpVerifyModel:
        return OtpVerifyModel.fromJson(json) as T;

      case ResetpwdOtpModel:
        return ResetpwdOtpModel.fromJson(json) as T;

      case ResendOtpModel:
        return ResendOtpModel.fromJson(json) as T;

      case RestaurantListModel:
        return RestaurantListModel.fromJson(json) as T;

      case EditCountryModel:
        return EditCountryModel.fromJson(json) as T;

      case EditStateModel:
        return EditStateModel.fromJson(json) as T;

      case EditCityModel:
        return EditCityModel.fromJson(json) as T;
        break;

      case UpdateProfileModel:
        return UpdateProfileModel.fromJson(json) as T;
        break;

      case RestaurantItemsModel:
        return RestaurantItemsModel.fromJson(json) as T;

      case ErrorModel:
        return ErrorModel.fromMap(json) as T;

      case RestaurantInfoModel:
        return RestaurantInfoModel.fromJson(json) as T;

      case GetRestaurantReview:
        return GetRestaurantReview.fromJson(json) as T;

      case WriteRestaurantReviewModel:
        return WriteRestaurantReviewModel.fromJson(json) as T;

      case CategoryListModel:
        return CategoryListModel.fromJson(json) as T;

      case AddItemPageModelList:
        return AddItemPageModelList.fromJson(json) as T;

      // case NotificationModel:
      //   return NotificationModel.fromJson(json) as T;
      case GetNotificationListModel:
        return GetNotificationListModel.fromJson(json) as T;

      case AddMenuToCartModel:
        return AddMenuToCartModel.fromJson(json) as T;

      case MenuCartDisplayModel:
        return MenuCartDisplayModel.fromJson(json) as T;

      case PlaceOrderModel:
        return PlaceOrderModel.fromJson(json) as T;

      case GetTableListModel:
        return GetTableListModel.fromJson(json) as T;

      case OrderDetailsModel:
        return OrderDetailsModel.fromJson(json) as T;

      case CurrentOrderDetailsModel:
        return CurrentOrderDetailsModel.fromJson(json) as T;

      case OrderStatusModel:
        return OrderStatusModel.fromJson(json) as T;

      case GetMyOrdersBookingHistory:
        return GetMyOrdersBookingHistory.fromJson(json) as T;

      case PaycheckoutNetbanking:
        return PaycheckoutNetbanking.fromJson(json) as T;

      case GetPeopleListModel:
        return GetPeopleListModel.fromJson(json) as T;

      case PaymentCheckoutModel:
        return PaymentCheckoutModel.fromJson(json) as T;

      default:
        break;
    }
  }
}
