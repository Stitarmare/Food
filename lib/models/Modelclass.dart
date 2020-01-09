import 'dart:async';

class LoginModel {
  int mobno;
  String password;
  LoginModel({this.mobno, this.password});

  factory LoginModel.fromMap(Map<String, dynamic> json) {
    return LoginModel(mobno: json["mobile_number"], password: json["password"]);
  }
}
