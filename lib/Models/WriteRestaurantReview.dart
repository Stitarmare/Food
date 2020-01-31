
import 'dart:convert';

WriteRestaurantReviewModel writeRestaurantReviewModelFromJson(String str) => WriteRestaurantReviewModel.fromJson(json.decode(str));

String writeRestaurantReviewModelToJson(WriteRestaurantReviewModel data) => json.encode(data.toJson());

class WriteRestaurantReviewModel {
    String status;
    int statusCode;
    String message;

    WriteRestaurantReviewModel({
        this.status,
        this.statusCode,
        this.message,
    });

    factory WriteRestaurantReviewModel.fromJson(Map<String, dynamic> json) => WriteRestaurantReviewModel(
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
