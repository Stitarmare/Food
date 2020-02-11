import 'dart:convert';

GetRestaurantReview getRestaurantReviewFromJson(String str) => GetRestaurantReview.fromJson(json.decode(str));

String getRestaurantReviewToJson(GetRestaurantReview data) => json.encode(data.toJson());

class GetRestaurantReview {
    String status;
    int statusCode;
    int page;
    int totalPages;
    List<RestaurantReviewList> data;

    GetRestaurantReview({
        this.status,
        this.statusCode,
        this.page,
        this.totalPages,
        this.data,
    });

    factory GetRestaurantReview.fromJson(Map<String, dynamic> json) => GetRestaurantReview(
        status: json["status"],
        statusCode: json["status_code"],
        page: json["page"],
        totalPages: json["totalPages"],
        data: List<RestaurantReviewList>.from(json["data"].map((x) => RestaurantReviewList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "page": page,
        "totalPages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class RestaurantReviewList {
    int id;
    int userId;
    int restId;
    String description;
    int rating;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    RestaurantReviewList({
        this.id,
        this.userId,
        this.restId,
        this.description,
        this.rating,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    factory RestaurantReviewList.fromJson(Map<String, dynamic> json) => RestaurantReviewList(
        id: json["id"],
        userId: json["user_id"],
        restId: json["rest_id"],
        description: json["description"],
        rating: json["rating"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "rest_id": restId,
        "description": description,
        "rating": rating,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
    };
}

class User {
    int id;
    String firstName;
    String lastName;
    dynamic userDetails;

    User({
        this.id,
        this.firstName,
        this.lastName,
        this.userDetails,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userDetails: json["user_details"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "user_details": userDetails,
    };
}