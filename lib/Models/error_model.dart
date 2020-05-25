class ErrorModel {
  String status;
  int statusCode;
  String message;
  List<String> mobileNumber;

  ErrorModel({this.status, this.statusCode, this.message, this.mobileNumber});

  factory ErrorModel.fromMap(Map<String, dynamic> json) {
    return ErrorModel(
      status: json['status'],
      statusCode: json['status_code'],
      message: json['message'],
      mobileNumber: json["mobile_number"] != null
          ? List<String>.from(json["mobile_number"])
          : null,
    );
  }
}
