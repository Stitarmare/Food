import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/authmodel.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Utils/String.dart';
import './api_model.dart';
import 'package:foodzi/Utils/globle.dart';
import 'url_constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

enum Environment { PRODUCTION, DEVLOPMENT, LOCAL }

class BaseUrl {
  BaseUrl();
  static var environment = Environment.PRODUCTION;
  static String getBaseUrl() {
    switch (environment) {
      case Environment.PRODUCTION:
        return STR_PRODUCTION_URL;
      case Environment.DEVLOPMENT:
        return STR_DEVELOPEMENT_URL;
      case Environment.LOCAL:
        return STR_LOCAL_URL;
      default:
        return STR_BLANK;
    }
  }

  static String getBaseUrlImages() {
    switch (environment) {
      case Environment.PRODUCTION:
        return STR_IMAGE_PRODUCTION_URL;
      case Environment.DEVLOPMENT:
        return STR_IMAGE_DEVELOPEMENT_URL;
      case Environment.LOCAL:
        return STR_IMAGE_LOCAL_URL;
      default:
        return STR_BLANK;
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
    return STR_BLANK;
  }

  Map<String, String> getHeader(String url) {
    switch (url) {
      case UrlConstant.loginApi:
        return {
          HttpHeaders.contentTypeHeader: STR_HEADER_TYPE,
          HttpHeaders.acceptHeader: STR_HEADER_TYPE
        };
      case UrlConstant.provideAnotherNumberApi:
        return {
          HttpHeaders.contentTypeHeader: STR_HEADER_TYPE,
          HttpHeaders.acceptHeader: STR_HEADER_TYPE
        };
      case UrlConstant.getCustomer:
        return {
          HttpHeaders.authorizationHeader: STR_BEARER + authToken(),
          HttpHeaders.contentTypeHeader: STR_HEADER_TYPE,
          HttpHeaders.acceptHeader: STR_HEADER_TYPE
        };
      case UrlConstant.updateProfileImage:
        return {
          HttpHeaders.authorizationHeader: STR_BEARER + authToken(),
          HttpHeaders.contentTypeHeader: STR_HEADER_TYPE,
          HttpHeaders.acceptHeader: STR_ACCEPT_HEADER
        };
      default:
        return {
          HttpHeaders.authorizationHeader: STR_BEARER + authToken(),
          HttpHeaders.contentTypeHeader: STR_HEADER_TYPE,
          HttpHeaders.acceptHeader: STR_HEADER_TYPE
        };
    }
  }

  Future<APIModel<T>> get<T>(String url, BuildContext context,
      {bool isShowDialoag}) async {
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
            STR_TIMEOUT,
            STR_SERVER_MSG,
            () {
              Navigator.of(context).pop();
            },
          );
        });
        return errorResponce<T>();
      }

      return _returnResponse<T>(response, context, isShowDialoag ?? false);
    } on SocketException {
      _showAlert(
        context,
        STR_WIFI_INTERNET,
        STR_NO_WIFI_INTERNET,
        () {
          Navigator.of(context).pop();
        },
      );
      return errorResponce<T>();
    }
  }

  Future<APIModel<T>> post<T>(String url, BuildContext context,
      {Map body, T model, bool isShowDialoag}) async {
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
            STR_TIMEOUT,
            STR_SERVER_MSG,
            () {
              Navigator.of(context).pop();
            },
          );
        });
        return errorResponce<T>();
      }
      return _returnResponse<T>(response, context, isShowDialoag ?? false);
    } on SocketException {
      _showAlert(
        context,
        STR_WIFI_INTERNET,
        STR_NO_WIFI_INTERNET,
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
      final request = http.MultipartRequest(STR_POST, postURL);
      request.headers.addAll(getHeader(url));
      if (body != null) {
        body.forEach((key, value) {
          request.fields[key] = value;
        });
      }
      var filePart = new http.MultipartFile.fromBytes(
        key,
        (await imageBody.readAsBytes()).buffer.asUint8List(),
        filename: '$key.jpg',
        contentType: MediaType('image', 'jpg'),
      );
      request.files.add(filePart);
      var res = await request.send();
      var myRes = await http.Response.fromStream(res);

      return _returnResponse<T>(myRes, context, false);
    } on SocketException {
      _showAlert(
        context,
        STR_WIFI_INTERNET,
        STR_NO_WIFI_INTERNET,
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
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(STR_OK),
                    onPressed: onPressed,
                  )
                ],
              ),
            ));
  }

  void showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 500),
    ));
  }

  APIModel _returnResponse<T>(
      http.Response response, BuildContext context, bool isShowDialoag) {
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
        print(response.body.toString());
        var responseJson = json.decode(response.body.toString());
        var errorModel = ErrorModel.fromMap(responseJson);
        var msg = "";

        if (errorModel != null) {
          if (errorModel.message != null) {
            msg = errorModel.message;
          }
          if(errorModel.mobileNumber != null) {
            if (errorModel.mobileNumber.length>0) {
              msg = errorModel.mobileNumber[0];
            }
          }
        }
        
        if (isShowDialoag != null) {
          if (isShowDialoag) {
            return apiModel;
          }
        }

        Future.delayed(const Duration(milliseconds: 100), () {
          _showAlert(context, STR_ERROR, msg, () {
            Navigator.of(context).pop();
          });
        });

        return apiModel;
      case 401:
        var apiModel = APIModel<T>();
        apiModel.result = SuccessType.failed;
        var responseJson = json.decode(response.body.toString());
        var errorModel = AuthModel.fromMap(responseJson);
        var msg = "";
        if (errorModel != null) {
          if (errorModel.message != null) {
            msg = errorModel.message;
          }
        }
        Future.delayed(const Duration(milliseconds: 100), () {
          _showAlert(context, STR_SESSION, msg, () {
            Navigator.of(context).pushReplacementNamed(STR_LOGIN_PAGE);
          });
        });
        return apiModel;
        break;
      case 403:
      case 404:
        var apiModel = APIModel<T>();
        apiModel.result = SuccessType.failed;
        json.decode(response.body.toString());

        Future.delayed(const Duration(milliseconds: 100), () {
          _showAlert(context, STR_ERROR, STR_COULD_NOT_ACCESS, () {
            Navigator.of(context).pushReplacementNamed(STR_LOGIN_PAGE);
          });
        });

        return apiModel;

      case 500:
      default:
        var apiModel = APIModel<T>();
        apiModel.result = SuccessType.failed;
        json.decode(response.body.toString());
        Future.delayed(const Duration(milliseconds: 100), () {
          _showAlert(
              context, STR_ERROR, STR_ERROR_MSG + '${response.statusCode}', () {
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
