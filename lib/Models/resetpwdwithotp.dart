import 'dart:convert';

// ResetpwdOtpModel resetpwdOtpModelFromJson(String str) => ResetpwdOtpModel.fromJson(json.decode(str));

// String resetpwdOtpModelToJson(ResetpwdOtpModel data) => json.encode(data.toJson());

class ResetpwdOtpModel {
  String status;
  int statusCode;
  String message;

  ResetpwdOtpModel({
    this.status,
    this.statusCode,
    this.message,
  });

  factory ResetpwdOtpModel.fromJson(Map<String, dynamic> json) =>
      ResetpwdOtpModel(
        status: json["status"],
        statusCode: json["status_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "message": message,
      };
}
