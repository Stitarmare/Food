import 'dart:convert';

RestaurantInfoModel restaurantInfoModelFromJson(String str) => RestaurantInfoModel.fromJson(json.decode(str));

String restaurantInfoModelToJson(RestaurantInfoModel data) => json.encode(data.toJson());

class RestaurantInfoModel {
    String status;
    int statusCode;
    RestaurantInfoData data;

    RestaurantInfoModel({
        this.status,
        this.statusCode,
        this.data,
    });

    factory RestaurantInfoModel.fromJson(Map<String, dynamic> json) => RestaurantInfoModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: RestaurantInfoData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": data.toJson(),
    };
}

class RestaurantInfoData {
    int id;
    String restName;
    String addressLine1;
    String addressLine2;
    String addressLine3;
    String contactNumber;
    String coverImage;
    String logo;
    String currency;
    String latitude;
    String longitude;
    String openingTime;
    String closingTime;
    String colourCode;
    int countryId;
    int stateId;
    int cityId;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;
    int averageRating;
    int reviewsCount;
    List<Review> reviews;
    List<Schedule> schedule;
    List<Category> category;
    List<Gallary> gallary;

    RestaurantInfoData({
        this.id,
        this.restName,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.contactNumber,
        this.coverImage,
        this.logo,
        this.currency,
        this.latitude,
        this.longitude,
        this.openingTime,
        this.closingTime,
        this.colourCode,
        this.countryId,
        this.stateId,
        this.cityId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.averageRating,
        this.reviewsCount,
        this.reviews,
        this.schedule,
        this.category,
        this.gallary,
    });

    factory RestaurantInfoData.fromJson(Map<String, dynamic> json) => RestaurantInfoData(
        id: json["id"],
        restName: json["rest_name"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        addressLine3: json["address_line_3"],
        contactNumber: json["contact_number"],
        coverImage: json["cover_image"],
        logo: json["logo"],
        currency: json["currency"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        colourCode: json["colour_code"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        averageRating: json["average_rating"],
        reviewsCount: json["reviews_count"],
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        schedule: List<Schedule>.from(json["schedule"].map((x) => Schedule.fromJson(x))),
        category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
        gallary: List<Gallary>.from(json["gallary"].map((x) => Gallary.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rest_name": restName,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "address_line_3": addressLine3,
        "contact_number": contactNumber,
        "cover_image": coverImage,
        "logo": logo,
        "currency": currency,
        "latitude": latitude,
        "longitude": longitude,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "colour_code": colourCode,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "average_rating": averageRating,
        "reviews_count": reviewsCount,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "gallary": List<dynamic>.from(gallary.map((x) => x.toJson())),
    };
}

class Category {
    int id;
    int workstationId;
    String name;
    int restId;
    dynamic createdAt;
    dynamic updatedAt;

    Category({
        this.id,
        this.workstationId,
        this.name,
        this.restId,
        this.createdAt,
        this.updatedAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        workstationId: json["workstation_id"],
        name: json["name"],
        restId: json["rest_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "workstation_id": workstationId,
        "name": name,
        "rest_id": restId,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class Gallary {
    int id;
    int restId;
    String imagePath;
    dynamic createdAt;
    dynamic updatedAt;

    Gallary({
        this.id,
        this.restId,
        this.imagePath,
        this.createdAt,
        this.updatedAt,
    });

    factory Gallary.fromJson(Map<String, dynamic> json) => Gallary(
        id: json["id"],
        restId: json["rest_id"],
        imagePath: json["image_path"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rest_id": restId,
        "image_path": imagePath,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class Review {
    int id;
    int userId;
    int restId;
    String description;
    int rating;
    DateTime createdAt;
    DateTime updatedAt;

    Review({
        this.id,
        this.userId,
        this.restId,
        this.description,
        this.rating,
        this.createdAt,
        this.updatedAt,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
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

class Schedule {
    int id;
    String dayOfWeek;
    String fromTime;
    String toTime;
    int restId;
    DateTime createdAt;
    DateTime updatedAt;

    Schedule({
        this.id,
        this.dayOfWeek,
        this.fromTime,
        this.toTime,
        this.restId,
        this.createdAt,
        this.updatedAt,
    });

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        dayOfWeek: json["day_of_week"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        restId: json["rest_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "day_of_week": dayOfWeek,
        "from_time": fromTime,
        "to_time": toTime,
        "rest_id": restId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}