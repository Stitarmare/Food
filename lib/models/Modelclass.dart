import 'dart:async';

class LoginModel {
  String mobno;
  String password;
  LoginModel({this.mobno, this.password});

  factory LoginModel.fromMap(Map<String, dynamic> json) {
    return LoginModel(mobno: json["mobile_number"], password: json["password"]);
  }
}

class RegisterModel {
  String first_name;
  String password;
  String mobno;
  String device_token;
  String device_type;
  String user_type;
  String last_name;

  RegisterModel(
      {this.mobno,
      this.password,
      this.first_name,
      this.device_token,
      this.device_type,
      this.last_name,
      this.user_type});

  factory RegisterModel.fromMap(Map<String, dynamic> json) {
    return RegisterModel(
        mobno: json["mobile_number"],
        password: json["password"],
        first_name: json['first_name']);
  }
}

class Otpviewmodel {
  String mobile_number;
  String otp;
  String device_token;
  String user_type;
  String device_type;

  Otpviewmodel({
    this.user_type,
    this.device_type,
    this.device_token,
    this.mobile_number,
  });

  factory Otpviewmodel.fromMap(Map<String, dynamic> json) {
    return Otpviewmodel(
      mobile_number: json["mobile_number"],
    );
  }
}
