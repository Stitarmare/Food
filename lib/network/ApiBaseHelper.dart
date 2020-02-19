import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Login/LoginView.dart';

import 'package:foodzi/Models/authmodel.dart';
import 'package:foodzi/Models/error_model.dart';

import './api_model.dart';
import 'package:foodzi/Utils/globle.dart';

import 'url_constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

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

  static String getBaseUrlImages() {
    switch (environment) {
      case Environment.PRODUCTION:
        return "";
      case Environment.DEVLOPMENT:
        return "http://foodzi.php-dev.in/storage/";
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

  static bool isUserAlreadyLogin() {
    if (Globle().authKey != null) {
      return true;
    } else {
      return false;
    }
  }

  ApiBaseHelper._internal();
  static var apiTimeStamp = Duration(seconds: 60);
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
      case UrlConstant.updateProfileImage:
        return {
          HttpHeaders.authorizationHeader: "Bearer " + authToken(),
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "multipart/form-data"
        };
      default:
        return {
          HttpHeaders.authorizationHeader: "Bearer " + authToken(),
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json"
        };
    }
  }

  Future<APIModel<T>> get<T>(String url, BuildContext context) async {
    try {
      var isTimeOut = false;
      final response = await http
          .get(_baseUrlString + url, headers: getHeader(url))
          .timeout(apiTimeStamp, onTimeout: () {
        isTimeOut = true;
      });
      if (isTimeOut) {
        Future.delayed(const Duration(milliseconds: 100), () {
          _showAlert(
            context,
            "Timeout",
            "Looks like the server is taking to long to respond, please try again in sometime.",
            () {
              Navigator.of(context).pop();
            },
          );
        });
        return errorResponce<T>();
      }

      return _returnResponse<T>(response, context);
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
      return errorResponce<T>();
    }
  }

  Future<APIModel<T>> post<T>(String url, BuildContext context,
      {Map body, T model}) async {
    try {
      var isTimeOut = false;
      final response = await http
          .post(_baseUrlString + url,
              headers: getHeader(url), body: json.encode(body))
          .timeout(apiTimeStamp, onTimeout: () {
        isTimeOut = true;
      });
      if (isTimeOut) {
        Future.delayed(const Duration(milliseconds: 100), () {
          _showAlert(
            context,
            "Timeout",
            "Looks like the server is taking to long to respond, please try again in sometime.",
            () {
              Navigator.of(context).pop();
            },
          );
        });
        return errorResponce<T>();
      }
      return _returnResponse<T>(response, context);
    } on SocketException {
      _showAlert(
        context,
        "Wifi/Internet",
        "Wifi/Internet not detected. Please activate it.",
        () {
          Navigator.of(context).pop();
        },
      );
      return errorResponce<T>();
    }
  }

  Future<APIModel<T>> imageUpload<T>(String url, BuildContext context,
      {Map<String, String> body, String key, File imageBody}) async {
    try {
      var postURL = Uri.parse(_baseUrlString + url);
      final request = http.MultipartRequest("POST", postURL);
      request.headers.addAll(getHeader(url));
      if (body != null) {
        body.forEach((key, value) {
          request.fields[key] = value;
        });
      }
      var filePart = new http.MultipartFile.fromBytes(
        key,
        (await imageBody.readAsBytes()).buffer.asUint8List(),
        filename: '$key.jpg', // use the real name if available, or omit
        contentType: MediaType('image', 'jpg'),
      );
      request.files.add(filePart);
      var res = await request.send();
      var myRes = await http.Response.fromStream(res);

      return _returnResponse<T>(myRes, context);
    } on SocketException {
      _showAlert(
        context,
        "Wifi/Internet",
        "Wifi/Internet not detected. Please activate it.",
        () {
          Navigator.of(context).pop();
        },
      );
      return errorResponce<T>();
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

  void showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 500),
    ));
  }

  APIModel _returnResponse<T>(http.Response response, BuildContext context) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var apiModel = APIModel<T>();
        apiModel.result = SuccessType.success;
        var responseJson = json.decode(response.body.toString());
        apiModel.model = GenericModel.fromJson(responseJson);
        return apiModel;

      case 400:
        var apiModel = APIModel<T>();
        apiModel.result = SuccessType.failed;
        var responseJson = json.decode(response.body.toString());
        var errorModel = ErrorModel.fromMap(responseJson);
        Future.delayed(const Duration(milliseconds: 200), () {
          _showAlert(context, "Error", errorModel.message, () {
            Navigator.of(context).pop();
          });
        });

        return apiModel;
      case 401:
        var apiModel = APIModel<T>();
        apiModel.result = SuccessType.failed;
        var responseJson = json.decode(response.body.toString());
        var errorModel = AuthModel.fromMap(responseJson);

        Future.delayed(const Duration(milliseconds: 200), () {
          _showAlert(context, "Session", errorModel.message, () {
            Navigator.of(context).pushReplacementNamed('/LoginView');
          });
        });
        return apiModel;
        break;
      case 403:
      case 404:
        var apiModel = APIModel<T>();
        apiModel.result = SuccessType.failed;
        var responseJson = json.decode(response.body.toString());
        //var errorModel = AuthModel.fromMap(responseJson);

        Future.delayed(const Duration(milliseconds: 200), () {
          _showAlert(context, "Error", "Could not access", () {
            Navigator.of(context).pushReplacementNamed('/LoginView');
          });
        });
        return apiModel;

      //throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        var apiModel = APIModel<T>();
        apiModel.result = SuccessType.failed;
        //var responseJson = json.decode(response.body.toString());
        //var errorModel = AuthModel.fromMap(responseJson);
        Future.delayed(const Duration(milliseconds: 200), () {
          _showAlert(context, "Error",
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
              () {
            Navigator.of(context).pop();
          });
        });

        return apiModel;
    }
  }

  APIModel errorResponce<T>() {
    var apiModel = APIModel<T>();
    apiModel.result = SuccessType.failed;
    return apiModel;
  }
}
