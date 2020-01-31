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
    String status;
    dynamic deletedAt;
    String averageRating;
    int reviewsCount;
    List<dynamic> reviews;
    List<Schedule> schedule;
    List<dynamic> category;
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
        this.status,
        this.deletedAt,
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
        status: json["status"],
        deletedAt: json["deleted_at"],
        averageRating: json["average_rating"],
        reviewsCount: json["reviews_count"],
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        schedule: List<Schedule>.from(json["schedule"].map((x) => Schedule.fromJson(x))),
        category: List<dynamic>.from(json["category"].map((x) => x)),
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
        "status": status,
        "deleted_at": deletedAt,
        "average_rating": averageRating,
        "reviews_count": reviewsCount,
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
        "category": List<dynamic>.from(category.map((x) => x)),
        "gallary": List<dynamic>.from(gallary.map((x) => x.toJson())),
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
