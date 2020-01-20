// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:foodzi/Login/LoginView.dart';

// import 'package:foodzi/Models/authmodel.dart';
// import 'package:foodzi/Models/error_model.dart';

// import './api_model.dart';
// import 'package:foodzi/Utils/globle.dart';

// import 'url_constant.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'dart:convert';

import 'dart:io';
import 'package:foodzi/models/authmodel.dart';
import 'package:foodzi/models/authmodel.dart';
import 'package:foodzi/network/url_constant.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Utils/globle.dart';
//import 'package:foodzi_waiter/util/router.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'app_exception.dart';

enum Environment { PRODUCTION, DEVLOPMENT, LOCAL }

class BaseUrl {
  BaseUrl();
  static var environment = Environment.DEVLOPMENT;
  static String getBaseUrl() {
    switch (environment) {
      case Environment.PRODUCTION:
        return "";
      case Environment.DEVLOPMENT:
        return "http://foodzi.php-dev.in/";
      case Environment.LOCAL:
        return "https://jsonplaceholder.typicode.com/";
      default:
        return "";
    }
  }
}

class ApiBaseHelper {
  static final ApiBaseHelper _apiBaseHelper = ApiBaseHelper._internal();
  factory ApiBaseHelper() {
    return _apiBaseHelper;
  }

  ApiBaseHelper._internal();

  var _baseUrlString = BaseUrl.getBaseUrl();

  String authToken() {
    if (Globle().authKey != null) {
      return Globle().authKey;
    }
    return "";
  }

  Map<String, String> getHeader(String url) {
    switch (url) {
      case UrlConstant.loginApi:
        return {
          //HttpHeaders.authorizationHeader: "Barier " + getAuthToken(),
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json"
        };
      case UrlConstant.getCustomer:
        return {
          HttpHeaders.authorizationHeader: "Bearer " + authToken(),
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json"
        };
      default:
        return {HttpHeaders.contentTypeHeader: "application/json"};
    }
  }

  Future<dynamic> get(String url, BuildContext context) async {
    try {
      final response =
          await http.get(_baseUrlString + url, headers: getHeader(url));
      return _returnResponse(response, context);
    } on SocketException {
      //throw FetchDataException('No Internet connection');
      _showAlert(
        context,
        "Wifi/Internet",
        "Wifi/Internet not detected. Please activate it.",
        () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  Future<dynamic> post(String url, BuildContext context, {Map body}) async {
    try {
      final response = await http.post(_baseUrlString + url,
          headers: getHeader(url), body: json.encode(body));
      return _returnResponse(response, context);
    } on SocketException {
      _showAlert(
        context,
        "Wifi/Internet",
        "Wifi/Internet not detected. Please activate it.",
        () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  Future<dynamic> imageUpload(String url, BuildContext context,
      Map<String, String> body, Map<String, String> imageBody) async {
    try {
      var postURL = Uri.parse(_baseUrlString + url);
      final request = http.MultipartRequest("POST", postURL);
      body.forEach((key, value) {
        request.fields[key] = value;
      });
      imageBody.forEach((key, value) {
        var filePart = new http.MultipartFile.fromString(key, value,
            filename: '$key.jpeg', contentType: new MediaType('image', 'jpeg'));
        request.files.add(filePart);
      });
      var response = await request.send();

      http.Response.fromStream(response).then((value) {
        _returnResponse(value, context);
      }).catchError((onError) {
        print(onError);
      });
    } on SocketException {
      _showAlert(
        context,
        "Wifi/Internet",
        "Wifi/Internet not detected. Please activate it.",
        () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  void _showAlert(
      BuildContext context, String title, String message, Function onPressed) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: onPressed,
                )
              ],
            ));
  }

  dynamic _returnResponse(http.Response response, BuildContext context) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
      case 401:
        var responseJson = json.decode(response.body.toString());
        var authMOdel = AuthModel.fromMap(responseJson);
        if (authMOdel.sessionExpired) {
          _showAlert(context, "Session", authMOdel.message, () {
            Navigator.of(context).pushReplacementNamed("/");
          });
        }
        break;
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

// enum Environment { PRODUCTION, DEVLOPMENT, LOCAL }

// class BaseUrl {
//   BaseUrl();
//   static var environment = Environment.DEVLOPMENT;
//   static String getBaseUrl() {
//     switch (environment) {
//       case Environment.PRODUCTION:
//         return "";
//       case Environment.DEVLOPMENT:
//         return "http://foodzi.php-dev.in/api/";
//       case Environment.LOCAL:
//         return "https://jsonplaceholder.typicode.com/";
//       default:
//         return "";
//     }
//   }
// }

// class ApiBaseHelper {
//   static final ApiBaseHelper _apiBaseHelper = ApiBaseHelper._internal();
//   factory ApiBaseHelper() {
//     return _apiBaseHelper;
//   }

//   ApiBaseHelper._internal();

//   var _baseUrlString = BaseUrl.getBaseUrl();

//   String authToken() {
//     if (Globle().authKey != null) {
//       return Globle().authKey;
//     }
//     return "";
//   }

//   Map<String, String> getHeader(String url) {
//     switch (url) {
//       case UrlConstant.loginApi:
//         return {
//           //HttpHeaders.authorizationHeader: "Barier " + getAuthToken(),
//           HttpHeaders.contentTypeHeader: "application/json",
//           HttpHeaders.acceptHeader: "application/json"
//         };
//       case UrlConstant.getCustomer:
//         return {
//           HttpHeaders.authorizationHeader: "Bearer " + authToken(),
//           HttpHeaders.contentTypeHeader: "application/json",
//           HttpHeaders.acceptHeader: "application/json"
//         };
//       default:
//         return {HttpHeaders.contentTypeHeader: "application/json"};
//     }
//   }

//   Future<APIModel<T>> get<T>(String url, BuildContext context) async {
//     try {
//       final response =
//           await http.get(_baseUrlString + url, headers: getHeader(url));

//       return _returnResponse<T>(response, context);
//     } on SocketException {
//       //throw FetchDataException('No Internet connection');
//       _showAlert(
//         context,
//         "Wifi/Internet",
//         "Wifi/Internet not detected. Please activate it.",
//         () {
//           Navigator.of(context).pop();
//         },
//       );
//       return errorResponce<T>();
//     }
//   }

//   Future<APIModel<T>> post<T>(String url, BuildContext context,
//       {Map body, T model}) async {
//     try {
//       final response = await http.post(_baseUrlString + url,
//           headers: getHeader(url), body: json.encode(body));
//       return _returnResponse<T>(response, context);
//     } on SocketException {
//       _showAlert(
//         context,
//         "Wifi/Internet",
//         "Wifi/Internet not detected. Please activate it.",
//         () {
//           Navigator.of(context).pop();
//         },
//       );
//       return errorResponce<T>();
//     }
//   }

//   Future<APIModel<T>> imageUpload<T>(String url, BuildContext context,
//       Map<String, String> body, Map<String, String> imageBody) async {
//     try {
//       var postURL = Uri.parse(_baseUrlString + url);
//       final request = http.MultipartRequest("POST", postURL);
//       body.forEach((key, value) {
//         request.fields[key] = value;
//       });
//       imageBody.forEach((key, value) {
//         var filePart = new http.MultipartFile.fromString(key, value,
//             filename: '$key.jpeg', contentType: new MediaType('image', 'jpeg'));
//         request.files.add(filePart);
//       });
//       var response = await request.send();

//       http.Response.fromStream(response).then((value) {
//         return _returnResponse<T>(value, context);
//       }).catchError((onError) {
//         print(onError);
//         return errorResponce<T>();
//       });
//     } on SocketException {
//       _showAlert(
//         context,
//         "Wifi/Internet",
//         "Wifi/Internet not detected. Please activate it.",
//         () {
//           Navigator.of(context).pop();
//         },
//       );
//       return errorResponce<T>();
//     }
//   }

//   void _showAlert(
//       BuildContext context, String title, String message, Function onPressed) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               title: Text(title),
//               content: Text(message),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text("Ok"),
//                   onPressed: onPressed,
//                 )
//               ],
//             ));
//   }

//   APIModel _returnResponse<T>(http.Response response, BuildContext context) {
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//         var apiModel = APIModel<T>();
//         apiModel.result = SuccessType.success;
//         var responseJson = json.decode(response.body.toString());
//         apiModel.model = GenericModel.fromJson(responseJson);
//         return apiModel;

//       case 400:
//         var apiModel = APIModel<T>();
//         apiModel.result = SuccessType.failed;
//         var responseJson = json.decode(response.body.toString());
//         var errorModel = ErrorModel.fromMap(responseJson);
//         _showAlert(context, "Error", errorModel.message, () {
//           Navigator.of(context).pop();
//         });
//         return apiModel;
//       case 401:
//         var apiModel = APIModel<T>();
//         apiModel.result = SuccessType.failed;
//         var responseJson = json.decode(response.body.toString());
//         var errorModel = AuthModel.fromMap(responseJson);
//         _showAlert(context, "Session", errorModel.message, () {
//           Navigator.of(context).pushReplacementNamed("/LoginView");
//         });

//         return apiModel;
//         break;
//       case 403:
//       case 404:
//         var apiModel = APIModel<T>();
//         apiModel.result = SuccessType.failed;
//         var responseJson = json.decode(response.body.toString());
//         //var errorModel = AuthModel.fromMap(responseJson);
//         _showAlert(context, "Error", "Could not access", () {
//           Navigator.of(context).pushReplacementNamed("/LoginView");
//         });

//         return apiModel;
//       //throw UnauthorisedException(response.body.toString());
//       case 500:
//       default:
//         var apiModel = APIModel<T>();
//         apiModel.result = SuccessType.failed;
//         var responseJson = json.decode(response.body.toString());
//         //var errorModel = AuthModel.fromMap(responseJson);
//         _showAlert(context, "Error",
//             'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
//             () {
//           Navigator.of(context).pushReplacementNamed("/");
//         });

//         return apiModel;
//     }
//   }

//   APIModel errorResponce<T>() {
//     var apiModel = APIModel<T>();
//     apiModel.result = SuccessType.failed;
//     return apiModel;
//   }
// }
