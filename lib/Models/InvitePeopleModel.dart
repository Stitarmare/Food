class InvitePeopleModel {
  String status;
  int statusCode;
  List<InvitePeopleList> data;

  InvitePeopleModel({this.status, this.statusCode, this.data});

  InvitePeopleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = new List<InvitePeopleList>();
      json['data'].forEach((v) {
        data.add(new InvitePeopleList.fromJson(v));
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

class InvitePeopleList {
  int id;
  int fromId;
  String inviteContactNumber;
  int toId;
  int orderId;
  int restId;
  int tableId;
  String status;
  String createdAt;
  String updatedAt;
  UserList toUser;

  InvitePeopleList(
      {this.id,
      this.fromId,
      this.inviteContactNumber,
      this.toId,
      this.orderId,
      this.restId,
      this.tableId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.toUser});

  InvitePeopleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['from_id'];
    inviteContactNumber = json['invite_contact_number'];
    toId = json['to_id'];
    orderId = json['order_id'];
    restId = json['rest_id'];
    tableId = json['table_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    toUser =
        json['to_user'] != null ? new UserList.fromJson(json['to_user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_id'] = this.fromId;
    data['invite_contact_number'] = this.inviteContactNumber;
    data['to_id'] = this.toId;
    data['order_id'] = this.orderId;
    data['rest_id'] = this.restId;
    data['table_id'] = this.tableId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.toUser != null) {
      data['to_user'] = this.toUser.toJson();
    }
    return data;
  }
}

class UserList {
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

  UserList(
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
      this.longitude});

  UserList.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
