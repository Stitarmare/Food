import 'dart:convert';

GetRestaurantReviewModel getRestaurantReviewModelFromJson(String str) => GetRestaurantReviewModel.fromJson(json.decode(str));

String getRestaurantReviewModelToJson(GetRestaurantReviewModel data) => json.encode(data.toJson());

class GetRestaurantReviewModel {
    String status;
    int statusCode;
    List<dynamic> getReview;

    GetRestaurantReviewModel({
        this.status,
        this.statusCode,
        this.getReview,
    });

    factory GetRestaurantReviewModel.fromJson(Map<String, dynamic> json) => GetRestaurantReviewModel(
        status: json["status"],
        statusCode: json["status_code"],
        getReview: List<dynamic>.from(json["data"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(getReview.map((x) => x)),
    };
}