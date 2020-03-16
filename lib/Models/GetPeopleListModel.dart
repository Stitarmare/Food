class GetPeopleListModel {
  String status;
  int statusCode;
  List<Data> data;

  GetPeopleListModel({this.status, this.statusCode, this.data});

  GetPeopleListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String firstName;
  String lastName;
  Null email;
  String mobileNumber;
  String status;
  String userType;
  Null accessToken;
  String deviceToken;
  String deviceType;
  int otp;
  Null emailVerifiedAt;
  Null deletedAt;
  String createdAt;
  String updatedAt;
  String latitude;
  String longitude;
  double distance;

  Data(
      {this.id,
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
      this.latitude,
      this.longitude,
      this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    status = json['status'];
    userType = json['user_type'];
    accessToken = json['access_token'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
    otp = json['otp'];
    emailVerifiedAt = json['email_verified_at'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['status'] = this.status;
    data['user_type'] = this.userType;
    data['access_token'] = this.accessToken;
    data['device_token'] = this.deviceToken;
    data['device_type'] = this.deviceType;
    data['otp'] = this.otp;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['distance'] = this.distance;
    return data;
  }
}
