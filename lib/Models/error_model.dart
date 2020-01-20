class ErrorModel {
  String status;
  int statusCode;
  String message;

  ErrorModel({this.status, this.statusCode, this.message});

  factory ErrorModel.fromMap(Map<String, dynamic> json) {
    return ErrorModel(
        status: json['status'],
        statusCode: json['status_code'],
        message: json['message']);
  }
}
