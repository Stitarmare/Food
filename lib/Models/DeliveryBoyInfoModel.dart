class DeliveryBoyModel {
  String status;
  int statusCode;
  DeliveryBoyInfoData data;

  DeliveryBoyModel({this.status, this.statusCode, this.data});

  DeliveryBoyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    data = json['data'] != null
        ? new DeliveryBoyInfoData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DeliveryBoyInfoData {
  int id;
  String firstName;
  String lastName;
  Null email;
  String countryCode;
  String mobileNumber;
  String status;
  String deliveryBoyStatus;
  String userType;
  Null accessToken;
  String deviceToken;
  String deviceType;
  int otp;
  Null emailVerifiedAt;
  String latitude;
  String longitude;
  Null deletedAt;
  String createdAt;
  String updatedAt;
  UserDetails userDetails;

  DeliveryBoyInfoData(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.countryCode,
      this.mobileNumber,
      this.status,
      this.deliveryBoyStatus,
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
      this.userDetails});

  DeliveryBoyInfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    countryCode = json['country_code'];
    mobileNumber = json['mobile_number'];
    status = json['status'];
    deliveryBoyStatus = json['delivery_boy_status'];
    userType = json['user_type'];
    accessToken = json['access_token'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
    otp = json['otp'];
    emailVerifiedAt = json['email_verified_at'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile_number'] = this.mobileNumber;
    data['status'] = this.status;
    data['delivery_boy_status'] = this.deliveryBoyStatus;
    data['user_type'] = this.userType;
    data['access_token'] = this.accessToken;
    data['device_token'] = this.deviceToken;
    data['device_type'] = this.deviceType;
    data['otp'] = this.otp;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails.toJson();
    }
    return data;
  }
}

class UserDetails {
  int id;
  int userId;
  Null addressLine1;
  Null addressLine2;
  Null addressLine3;
  Null countryId;
  Null stateId;
  Null cityId;
  Null postalCode;
  String profileImage;
  String licenseImage;
  int radius;
  String createdAt;
  String updatedAt;

  UserDetails(
      {this.id,
      this.userId,
      this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.countryId,
      this.stateId,
      this.cityId,
      this.postalCode,
      this.profileImage,
      this.licenseImage,
      this.radius,
      this.createdAt,
      this.updatedAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    addressLine3 = json['address_line_3'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    postalCode = json['postal_code'];
    profileImage = json['profile_image'];
    licenseImage = json['license_image'];
    radius = json['radius'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address_line_1'] = this.addressLine1;
    data['address_line_2'] = this.addressLine2;
    data['address_line_3'] = this.addressLine3;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['postal_code'] = this.postalCode;
    data['profile_image'] = this.profileImage;
    data['license_image'] = this.licenseImage;
    data['radius'] = this.radius;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
