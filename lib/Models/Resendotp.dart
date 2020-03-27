class ResendOtpModel {
  String status;
  int statusCode;
  String message;

  ResendOtpModel({
    this.status,
    this.statusCode,
    this.message,
  });

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) => ResendOtpModel(
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
