class LoginWithOtpModel {
  String status;
  int statusCode;
  String message;

  LoginWithOtpModel({
    this.status,
    this.statusCode,
    this.message,
  });

  factory LoginWithOtpModel.fromJson(Map<String, dynamic> json) =>
      LoginWithOtpModel(
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
