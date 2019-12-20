import 'dart:io';
import 'package:foodzi/network/url_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'app_exception.dart';

enum Environment { PRODUCTION, DEVLOPMENT, LOCAL }

class BaseUrl {
  BaseUrl();
  static var environment = Environment.LOCAL;
  static String getBaseUrl() {
    switch (environment) {
      case Environment.PRODUCTION:
        return "";
      case Environment.DEVLOPMENT:
        return "https://irmeetings.krahejacorp.co.in/Api/";
      case Environment.LOCAL:
        return "https://jsonplaceholder.typicode.com/";
      default:
        return "";
    }
  }
}

class ApiBaseHelper {
  ApiBaseHelper._internal();

  static final ApiBaseHelper _apiBaseHelper = ApiBaseHelper._internal();
  factory ApiBaseHelper() {
    return _apiBaseHelper;
  }

  var _baseUrlString = BaseUrl.getBaseUrl();

  static const AUTH_TOKEN = "";

  static Map<String, String> getHeader(String url) {
    switch (url) {
      case UrlConstant.POSTS:
        return {
          HttpHeaders.authorizationHeader: AUTH_TOKEN,
          HttpHeaders.contentTypeHeader: "application/json"
        };
      case UrlConstant.UPDATEPROFILE:
        return {
          HttpHeaders.authorizationHeader: AUTH_TOKEN,
          HttpHeaders.contentTypeHeader: "multipart/form-data"
        };

      default:
        return {HttpHeaders.contentTypeHeader: "application/json"};
    }
  }

  Future<dynamic> get(String url, BuildContext context) async {
    try {
      final response =
          await http.get(_baseUrlString + url, headers: getHeader(url));
      return _returnResponse(response);
    } on SocketException {
      //throw FetchDataException('No Internet connection');
      _showAlert(context);
    }
  }

  Future<dynamic> post(String url, BuildContext context, {Map body}) async {
    try {
      final response = await http.post(_baseUrlString + url,
          headers: getHeader(url), body: json.encode(body));
      return _returnResponse(response);
    } on SocketException {
      _showAlert(context);
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
        _returnResponse(value);
      }).catchError((onError) {
        print(onError);
      });
    } on SocketException {
      _showAlert(context);
    }
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Wifi/Internet"),
              content: Text("Wifi/Internet not detected. Please activate it."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
      case 400:
        //prase error model and show error here
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
