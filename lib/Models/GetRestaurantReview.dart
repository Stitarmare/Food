import 'dart:convert';

GetRestaurantReview getRestaurantReviewFromJson(String str) => GetRestaurantReview.fromJson(json.decode(str));

String getRestaurantReviewToJson(GetRestaurantReview data) => json.encode(data.toJson());

class GetRestaurantReview {
    String status;
    int statusCode;
    RestaurantReviewData data;

    GetRestaurantReview({
        this.status,
        this.statusCode,
        this.data,
    });

    factory GetRestaurantReview.fromJson(Map<String, dynamic> json) => GetRestaurantReview(
        status: json["status"],
        statusCode: json["status_code"],
        data: RestaurantReviewData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": data.toJson(),
    };
}

class RestaurantReviewData {
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
    List<Review> reviews;

    RestaurantReviewData({
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
        this.reviews,
    });

    factory RestaurantReviewData.fromJson(Map<String, dynamic> json) => RestaurantReviewData(
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
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
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
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
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
    User user;

    Review({
        this.id,
        this.userId,
        this.restId,
        this.description,
        this.rating,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
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
    dynamic email;
    String mobileNumber;
    String status;
    String userType;
    dynamic accessToken;
    String deviceToken;
    String deviceType;
    int otp;
    dynamic emailVerifiedAt;
    dynamic deletedAt;
    DateTime createdAt;
    DateTime updatedAt;
    UserDetails userDetails;

    User({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.mobileNumber,
        this.status,
        this.userType,
        this.accessToken,
        this.deviceToken,
        this.deviceType,
        this.otp,
        this.emailVerifiedAt,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.userDetails,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        status: json["status"],
        userType: json["user_type"],
        accessToken: json["access_token"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        otp: json["otp"],
        emailVerifiedAt: json["email_verified_at"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userDetails: UserDetails.fromJson(json["user_details"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile_number": mobileNumber,
        "status": status,
        "user_type": userType,
        "access_token": accessToken,
        "device_token": deviceToken,
        "device_type": deviceType,
        "otp": otp,
        "email_verified_at": emailVerifiedAt,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_details": userDetails.toJson(),
    };
}

class UserDetails {
    int id;
    int userId;
    dynamic addressLine1;
    dynamic addressLine2;
    dynamic addressLine3;
    dynamic countryId;
    dynamic stateId;
    dynamic cityId;
    dynamic postalCode;
    String profileImage;
    DateTime createdAt;
    DateTime updatedAt;

    UserDetails({
        this.id,
        this.userId,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.countryId,
        this.stateId,
        this.cityId,
        this.postalCode,
        this.profileImage,
        this.createdAt,
        this.updatedAt,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"],
        userId: json["user_id"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        addressLine3: json["address_line_3"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        postalCode: json["postal_code"],
        profileImage: json["profile_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "address_line_3": addressLine3,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "postal_code": postalCode,
        "profile_image": profileImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}