// class GetPeopleListModel {
//   String status;
//   int statusCode;
//   List<PeopleData> data;

//   GetPeopleListModel({this.status, this.statusCode, this.data});

//   GetPeopleListModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     statusCode = json['status_code'];
//     if (json['data'] != null) {
//       data = new List<PeopleData>();
//       json['data'].forEach((v) {
//         data.add(new PeopleData.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['status_code'] = this.statusCode;
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class PeopleData {
//   int id;
//   String firstName;
//   String lastName;
//   Null email;
//   String mobileNumber;
//   String status;
//   String userType;
//   Null accessToken;
//   String deviceToken;
//   String deviceType;
//   int otp;
//   Null emailVerifiedAt;
//   Null deletedAt;
//   String createdAt;
//   String updatedAt;
//   String latitude;
//   String longitude;
//   String distance;
//   Map<String, int> userDetails;

//   PeopleData({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.mobileNumber,
//     this.status,
//     this.userType,
//     this.accessToken,
//     this.deviceToken,
//     this.deviceType,
//     this.otp,
//     this.emailVerifiedAt,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.latitude,
//     this.longitude,
//     this.distance,
//     this.userDetails,
//   });

//   PeopleData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     mobileNumber = json['mobile_number'];
//     status = json['status'];
//     userType = json['user_type'];
//     accessToken = json['access_token'];
//     deviceToken = json['device_token'];
//     deviceType = json['device_type'];
//     otp = json['otp'];
//     emailVerifiedAt = json['email_verified_at'];
//     deletedAt = json['deleted_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     distance = json['distance'];
//     userDetails: json["user_details"] == null ? null : Map.from(json["user_details"]).map((k, v) => MapEntry<String, int>(k, v == null ? null : v));

//   }

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "country_code": countryCode,
//         "mobile_number": mobileNumber,
//         "status": status,
//         "user_type": userType,
//         "access_token": accessToken,
//         "device_token": deviceToken,
//         "device_type": deviceType,
//         "otp": otp,
//         "email_verified_at": emailVerifiedAt,
//         "latitude": latitude,
//         "longitude": longitude,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "distance": distance,
//         "user_details": userDetails == null ? null : Map.from(userDetails).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)),
//     };
// }

import 'dart:convert';

GetPeopleListModel getPeopleListModelFromJson(String str) =>
    GetPeopleListModel.fromJson(json.decode(str));

String getPeopleListModelToJson(GetPeopleListModel data) =>
    json.encode(data.toJson());

class GetPeopleListModel {
  String status;
  int statusCode;
  List<PeopleData> data;

  GetPeopleListModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory GetPeopleListModel.fromJson(Map<String, dynamic> json) =>
      GetPeopleListModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<PeopleData>.from(
            json["data"].map((x) => PeopleData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PeopleData {
  int id;
  String firstName;
  String lastName;
  dynamic email;
  dynamic countryCode;
  String mobileNumber;
  String status;
  String userType;
  dynamic accessToken;
  String deviceToken;
  String deviceType;
  String otp;
  dynamic emailVerifiedAt;
  String latitude;
  String longitude;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String distance;
  UserDetails userDetails;

  PeopleData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
    this.mobileNumber,
    this.status,
    this.userType,
    this.accessToken,
    this.deviceToken,
    this.deviceType,
    this.otp,
    this.emailVerifiedAt,
    this.latitude,
    this.longitude,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.distance,
    this.userDetails,
  });

  factory PeopleData.fromJson(Map<String, dynamic> json) => PeopleData(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        countryCode: json["country_code"],
        mobileNumber: json["mobile_number"],
        status: json["status"],
        userType: json["user_type"],
        accessToken: json["access_token"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        otp: json["otp"],
        emailVerifiedAt: json["email_verified_at"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        distance: json["distance"],
        userDetails: json["user_details"] != null
            ? UserDetails.fromJson(json["user_details"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "country_code": countryCode,
        "mobile_number": mobileNumber,
        "status": status,
        "user_type": userType,
        "access_token": accessToken,
        "device_token": deviceToken,
        "device_type": deviceType,
        "otp": otp,
        "email_verified_at": emailVerifiedAt,
        "latitude": latitude,
        "longitude": longitude,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "distance": distance,
        "user_details": userDetails != null ? userDetails.toJson() : null,
      };
}

class UserDetails {
  int id;
  int userId;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  int countryId;
  int stateId;
  int cityId;
  String postalCode;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic profileImage;

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
    this.createdAt,
    this.updatedAt,
    this.profileImage,
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profileImage: json["profile_image"],
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "profile_image": profileImage,
      };
}

class InvitePeople {
  int inviteId;

  InvitePeople({
    this.inviteId,
  });

  factory InvitePeople.fromJson(Map<String, dynamic> json) => InvitePeople(
        inviteId: json["invite_id"],
      );

  Map<String, dynamic> toJson() => {
        "invite_id": inviteId,
      };
}
