import 'dart:convert';

GetRestaurantReviewModel getRestaurantReviewModelFromJson(String str) => GetRestaurantReviewModel.fromJson(json.decode(str));

String getRestaurantReviewModelToJson(GetRestaurantReviewModel data) => json.encode(data.toJson());

class GetRestaurantReviewModel {
    String status;
    int statusCode;
    List<Datum> data;

    GetRestaurantReviewModel({
        this.status,
        this.statusCode,
        this.data,
    });

    factory GetRestaurantReviewModel.fromJson(Map<String, dynamic> json) => GetRestaurantReviewModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    int userId;
    int restId;
    String description;
    int rating;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        this.id,
        this.userId,
        this.restId,
        this.description,
        this.rating,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        restId: json["rest_id"],
        description: json["description"],
        rating: json["rating"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "rest_id": restId,
        "description": description,
        "rating": rating,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}