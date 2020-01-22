import 'package:flutter/material.dart';
import 'package:foodzi/Models/Otpverify.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Models/loginmodel.dart';

import 'package:foodzi/Otp/OtpContractor.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/network/api_model.dart';
import 'package:foodzi/network/url_constant.dart';

import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';

class OtpPresenter extends OtpContract {
  OTPModelView otpView;

  OtpPresenter(OTPModelView mView) {
    this.otpView = mView;
  }

  @override
  void onBackPresed() {}

  void perfromresetpassword(String mobno, BuildContext context) {
    ApiBaseHelper()
        .post<ErrorModel>(UrlConstant.resetpassverifyotp, context, body: {
      'mobile_number': mobno,
      'device_token': "dsa",
      'device_type': "1",
      'user_type': "customer",
      'otp': '123456',
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("Success");
          print(value.model);
          otpView.getSuccesForForgetPass();
          break;
        case SuccessType.failed:
          print("Failed");
          otpView.getFailedForForgetPass();
          break;
      }
      // if (value['status_code'] == 200) {
      //   otpView.getSuccesForForgetPass();
      // } else {
      //   otpView.getFailedForForgetPass();
      // }
    }).catchError((error) {
      print(error);
    });
//ApiCall
    //;
  }

  void performOTP(String mobno, String otp, BuildContext context) {
    ApiBaseHelper().post<LoginModel>(UrlConstant.verifyotp, context, body: {
      'otp': otp,
      'device_token': 'gfgfg',
      'user_type': 'customer',
      'device_type': '1',
      'mobile_number': mobno,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("success");
          print(value.model);
          Globle().loginModel = value.model;
          Globle().authKey = value.model.token;
          otpView.otpsuccess();
          break;
        case SuccessType.failed:
          print("failed");
          otpView.otpfailed();
          break;
      }
      // if (value['status_code'] == 200) {
      //   Globle().loginModel = LoginModel.fromJson(value);

      //   otpView.otpsuccess();
      // }
    }).catchError((error) {
      print(error);
    });
//ApiCall
    //;
  }

  void performresendOTP(String mobno, String otp, BuildContext context) {
    ApiBaseHelper().post(UrlConstant.verifyotp, context, body: {
      // 'otp': otp,
      // 'device_token': 'gfgfg',
      // 'user_type': 'customer',
      // 'device_type': '1',
      'mobile_number': mobno,
    }).then((value) {
      print(value);
      switch (value.result) {
        case SuccessType.success:
          print("success");
          print(value.model);
          otpView.otpsuccess();
          break;
        case SuccessType.failed:
          print("failed");
          otpView.otpfailed();
          break;
      }
      // if (value['status_code'] == 200) {
      //   otpView.otpsuccess();
      // }
    }).catchError((error) {
      print(error);
    });
//ApiCall
    //;
  }

  @override
  void verifyotp(String mobno, BuildContext context) {
    // TODO: implement verifyotp
  }
}

// import 'package:flutter/material.dart';
// import 'package:foodzi/Models/Otpverify.dart';
// import 'package:foodzi/Models/loginwithotp.dart';

// import 'package:foodzi/Otp/OtpContractor.dart';
// import 'package:foodzi/network/ApiBaseHelper.dart';
// import 'package:foodzi/network/api_model.dart';
// import 'package:foodzi/network/url_constant.dart';

// import 'package:foodzi/Utils/globle.dart';
// import 'package:foodzi/Utils/shared_preference.dart';

// abstract class OtpPresenterInterface {
//   void otpSuccess();
//   void otpFailed();
// }

// class OtpPresenter {
//   OtpPresenterInterface view;
//   //OTPModelView otpView;

//   OtpPresenter({this.view});
//   //{
//   //this.otpView = mView;
//   //}

//   callloginwithotpApi(String mobNo, BuildContext context) {
//     ApiBaseHelper()
//         .post<LoginWithOtpModel>(UrlConstant.loginwithOTP, context, body: {
//       "mobile_number": mobNo,
//     }).then((value) {
//       print(value.model);
//       switch (value.result) {
//         case SuccessType.success:
//           print("success");
//           break;
//         case SuccessType.failed:
//           print("failed");
//           break;
//       }
//     }).catchError((error) {
//       print(error);
//     });
//   }

//   void perfromresetpassword(String mobno, BuildContext context) {
//     ApiBaseHelper().post(UrlConstant.resetpassverifyotp, context, body: {
//       'mobile_number': mobno,
//       'device_token': "dsa",
//       'device_type': "1",
//       'user_type': "customer",
//       'otp': '123456',
//     }).then((value) {
//       print(value.model);
//       switch (value.result) {
//         case SuccessType.success:
//           print("success");
//           break;
//         case SuccessType.failed:
//           print("failed");
//           break;
//       }
//     }).catchError((error) {
//       print(error);
//     });

//     // then((value) {
//     //   print(value);
//     //   if (value['status_code'] == 200) {
//     //     otpView.getSuccesForForgetPass();
//     //   } else {
//     //     otpView.getFailedForForgetPass();
//     //   }
//     // });
// //ApiCall
//     //;
//   }

//   void performOTP(String mobno, String otp, BuildContext context) {
//     ApiBaseHelper().post(UrlConstant.verifyotp, context, body: {
//       'otp': otp,
//       'device_token': 'gfgfg',
//       'user_type': 'customer',
//       'device_type': '1',
//       'mobile_number': mobno,
//     }).then((value) {
//       print(value.model);
//       switch (value.result) {
//         case SuccessType.success:
//           print("success");
//           break;
//         case SuccessType.failed:
//           print("failed");
//           break;
//       }
//     }).catchError((error) {
//       print(error);
//     });
// //     }).then((value) {
// //       print(value);
// //       if (value['status_code'] == 200) {
// //         Globle().loginModel = LoginModel.fromJson(value);

// //         otpView.otpsuccess();
// //       }
// //     });
// // //ApiCall
// //     //;
// //   }

//     void performresendOTP(String mobno, String otp, BuildContext context) {
//       ApiBaseHelper().post(UrlConstant.verifyotp, context, body: {
//         // 'otp': otp,
//         // 'device_token': 'gfgfg',
//         // 'user_type': 'customer',
//         // 'device_type': '1',
//         'mobile_number': mobno,
//       }).then((value) {
//         print(value.model);
//         switch (value.result) {
//           case SuccessType.success:
//             print("success");
//             break;
//           case SuccessType.failed:
//             print("failed");
//             break;
//         }
//       }).catchError((error) {
//         print(error);
//       });
// //     }).then((value) {
// //       print(value);
// //       if (value['status_code'] == 200) {
// //         otpView.otpsuccess();
// //       }
// //     });
// // //ApiCall
// //     //;
// //   }

//       @override
//       void verifyotp(String mobno, BuildContext context) {
//         // TODO: implement verifyotp
//       }
//     }
//   }
// }
