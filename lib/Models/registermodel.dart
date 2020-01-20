import 'dart:convert';

class Registermodel {
  String status;
  int statusCode;
  String message;
  String token;
  Data data;

  Registermodel({
    this.status,
    this.statusCode,
    this.message,
    this.token,
    this.data,
  });

  factory Registermodel.fromJson(Map<String, dynamic> json) => Registermodel(
        status: json["status"],
        statusCode: json["status_code"],
        message: json["message"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "message": message,
        "token": token,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String firstName;
  String lastName;
  dynamic email;
  String mobileNumber;
  String status;
  String userType;
  dynamic accessToken;
  String deviceToken;
  String deviceType;
  int otp;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.status,
    this.userType,
    this.accessToken,
    this.deviceToken,
    this.deviceType,
    this.otp,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        status: json["status"],
        userType: json["user_type"],
        accessToken: json["access_token"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        otp: json["otp"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile_number": mobileNumber,
        "status": status,
        "user_type": userType,
        "access_token": accessToken,
        "device_token": deviceToken,
        "device_type": deviceType,
        "otp": otp,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
