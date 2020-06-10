import 'package:foodzi/Models/UpdateprofileModel.dart';

class LoginModel {
  String status;
  String token;
  int statusCode;
  Data data;

  LoginModel({
    this.status,
    this.token,
    this.statusCode,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        token: json["token"],
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "status_code": statusCode,
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
  String otp;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String colourCode;
  UserDetails userDetails;

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
    this.colourCode,
    this.userDetails,
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
        userDetails: json["user_details"] != null
            ? UserDetails.fromJson(json["user_details"])
            : null,
//colourCode: json["colour_code"],
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
        "user_details": userDetails != null ? userDetails.toJson() : null,
      };
}
