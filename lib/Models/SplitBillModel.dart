import 'dart:convert';

SplitBillEqualModel splitBillEqualModelFromJson(String str) =>
    SplitBillEqualModel.fromJson(json.decode(str));

String splitBillEqualModelToJson(SplitBillEqualModel data) =>
    json.encode(data.toJson());

class SplitBillEqualModel {
  String status;
  int statusCode;
  Data data;

  SplitBillEqualModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory SplitBillEqualModel.fromJson(Map<String, dynamic> json) =>
      SplitBillEqualModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": data.toJson(),
      };
}

class Data {
  String equalAmount;
  List<int> userIds;

  Data({
    this.equalAmount,
    this.userIds,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        equalAmount: json["equalAmount"],
        userIds: List<int>.from(json["userIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "equalAmount": equalAmount,
        "userIds": List<dynamic>.from(userIds.map((x) => x)),
      };
}

class SplitBillCertainPeopleModel {
  String status;
  int statusCode;
  List<SplitBillCertainPeopleList> data;

  SplitBillCertainPeopleModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory SplitBillCertainPeopleModel.fromJson(Map<String, dynamic> json) =>
      SplitBillCertainPeopleModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<SplitBillCertainPeopleList>.from(
            json["data"].map((x) => SplitBillCertainPeopleList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SplitBillCertainPeopleList {
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
  String otp;
  dynamic emailVerifiedAt;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String latitude;
  String longitude;
  List<ListElement> lists;

  SplitBillCertainPeopleList({
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
    this.latitude,
    this.longitude,
    this.lists,
  });

  factory SplitBillCertainPeopleList.fromJson(Map<String, dynamic> json) =>
      SplitBillCertainPeopleList(
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
        latitude: json["latitude"],
        longitude: json["longitude"],
        lists: List<ListElement>.from(
            json["lists"].map((x) => ListElement.fromJson(x))),
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
        "latitude": latitude,
        "longitude": longitude,
        "lists": List<dynamic>.from(lists.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement();

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement();

  Map<String, dynamic> toJson() => {};
}

class SplitBillOrderItemsModel {
  String status;
  int statusCode;
  List<SplitBillOrderItemsList> data;

  SplitBillOrderItemsModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory SplitBillOrderItemsModel.fromJson(Map<String, dynamic> json) =>
      SplitBillOrderItemsModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<SplitBillOrderItemsList>.from(
            json["data"].map((x) => SplitBillOrderItemsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SplitBillOrderItemsList {
  int id;
  String itemName;
  String price;
  String itemDescription;
  int workstationId;
  int restId;
  String menuType;
  String availability;
  String defaultPreparationTime;
  String itemCode;
  String itemImage;
  DateTime createdAt;
  DateTime updatedAt;

  SplitBillOrderItemsList({
    this.id,
    this.itemName,
    this.price,
    this.itemDescription,
    this.workstationId,
    this.restId,
    this.menuType,
    this.availability,
    this.defaultPreparationTime,
    this.itemCode,
    this.itemImage,
    this.createdAt,
    this.updatedAt,
  });

  factory SplitBillOrderItemsList.fromJson(Map<String, dynamic> json) =>
      SplitBillOrderItemsList(
        id: json["id"],
        itemName: json["item_name"],
        price: json["price"] == null ? null : json["price"],
        itemDescription: json["item_description"],
        workstationId: json["workstation_id"],
        restId: json["rest_id"],
        menuType: json["menu_type"],
        availability: json["availability"],
        defaultPreparationTime: json["default_preparation_time"],
        itemCode: json["item_code"],
        itemImage: json["item_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "price": price == null ? null : price,
        "item_description": itemDescription,
        "workstation_id": workstationId,
        "rest_id": restId,
        "menu_type": menuType,
        "availability": availability,
        "default_preparation_time": defaultPreparationTime,
        "item_code": itemCode,
        "item_image": itemImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class SplitBillOrderItemsByUserModel {
  String status;
  int statusCode;
  List<SplitBillOrderItemsByUserList> data;

  SplitBillOrderItemsByUserModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory SplitBillOrderItemsByUserModel.fromJson(Map<String, dynamic> json) =>
      SplitBillOrderItemsByUserModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<SplitBillOrderItemsByUserList>.from(
            json["data"].map((x) => SplitBillOrderItemsByUserList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SplitBillOrderItemsByUserList {
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
  String latitude;
  String longitude;
  List<ListElement> lists;

  SplitBillOrderItemsByUserList({
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
    this.latitude,
    this.longitude,
    this.lists,
  });

  factory SplitBillOrderItemsByUserList.fromJson(Map<String, dynamic> json) =>
      SplitBillOrderItemsByUserList(
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
        latitude: json["latitude"],
        longitude: json["longitude"],
        lists: List<ListElement>.from(
            json["lists"].map((x) => ListElement.fromJson(x))),
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
        "latitude": latitude,
        "longitude": longitude,
        "lists": List<dynamic>.from(lists.map((x) => x.toJson())),
      };
}

class SplitBillOrderItemsSplitList {
  int id;
  int quantity;
  String preparationTime;
  int itemId;
  int itemSizePriceId;
  int tableId;
  int orderId;
  int userId;
  int restId;
  dynamic price;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String sizePrice;

  SplitBillOrderItemsSplitList({
    this.id,
    this.quantity,
    this.preparationTime,
    this.itemId,
    this.itemSizePriceId,
    this.tableId,
    this.orderId,
    this.userId,
    this.restId,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.sizePrice,
  });

  factory SplitBillOrderItemsSplitList.fromJson(Map<String, dynamic> json) =>
      SplitBillOrderItemsSplitList(
        id: json["id"],
        quantity: json["quantity"],
        preparationTime: json["preparation_time"],
        itemId: json["item_id"],
        itemSizePriceId: json["item_size_price_id"],
        tableId: json["table_id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        restId: json["rest_id"],
        price: json["price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sizePrice: json["size_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "preparation_time": preparationTime,
        "item_id": itemId,
        "item_size_price_id": itemSizePriceId,
        "table_id": tableId,
        "order_id": orderId,
        "user_id": userId,
        "rest_id": restId,
        "price": price,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "size_price": sizePrice,
      };
}

class SplitBillOrderModel {
  String status;
  int statusCode;
  List<Datum> data;

  SplitBillOrderModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory SplitBillOrderModel.fromJson(Map<String, dynamic> json) =>
      SplitBillOrderModel(
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
  String itemName;
  String price;
  String itemDescription;
  int workstationId;
  int restId;
  String menuType;
  String availability;
  String defaultPreparationTime;
  String itemCode;
  String itemImage;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    this.id,
    this.itemName,
    this.price,
    this.itemDescription,
    this.workstationId,
    this.restId,
    this.menuType,
    this.availability,
    this.defaultPreparationTime,
    this.itemCode,
    this.itemImage,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        itemName: json["item_name"],
        price: json["price"] == null ? null : json["price"],
        itemDescription: json["item_description"],
        workstationId: json["workstation_id"],
        restId: json["rest_id"],
        menuType: json["menu_type"],
        availability: json["availability"],
        defaultPreparationTime: json["default_preparation_time"],
        itemCode: json["item_code"],
        itemImage: json["item_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "price": price == null ? null : price,
        "item_description": itemDescription,
        "workstation_id": workstationId,
        "rest_id": restId,
        "menu_type": menuType,
        "availability": availability,
        "default_preparation_time": defaultPreparationTime,
        "item_code": itemCode,
        "item_image": itemImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

//if option type is 4(split based on items ordered by users)

class SplitBillOrderByUserModel {
  String status;
  int statusCode;
  List<SplitBillOrderByUserList> data;

  SplitBillOrderByUserModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory SplitBillOrderByUserModel.fromJson(Map<String, dynamic> json) =>
      SplitBillOrderByUserModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<SplitBillOrderByUserList>.from(
            json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SplitBillOrderByUserList {
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
  String latitude;
  String longitude;
  List<ListElement> lists;

  SplitBillOrderByUserList({
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
    this.latitude,
    this.longitude,
    this.lists,
  });

  factory SplitBillOrderByUserList.fromJson(Map<String, dynamic> json) =>
      SplitBillOrderByUserList(
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
        latitude: json["latitude"],
        longitude: json["longitude"],
        lists: List<ListElement>.from(
            json["lists"].map((x) => ListElement.fromJson(x))),
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
        "latitude": latitude,
        "longitude": longitude,
        "lists": List<dynamic>.from(lists.map((x) => x.toJson())),
      };
}

class ListElements {
  int id;
  int quantity;
  String preparationTime;
  int itemId;
  int itemSizePriceId;
  int tableId;
  int orderId;
  int userId;
  int restId;
  dynamic price;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String sizePrice;

  ListElements({
    this.id,
    this.quantity,
    this.preparationTime,
    this.itemId,
    this.itemSizePriceId,
    this.tableId,
    this.orderId,
    this.userId,
    this.restId,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.sizePrice,
  });

  factory ListElements.fromJson(Map<String, dynamic> json) => ListElements(
        id: json["id"],
        quantity: json["quantity"],
        preparationTime: json["preparation_time"],
        itemId: json["item_id"],
        itemSizePriceId: json["item_size_price_id"],
        tableId: json["table_id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        restId: json["rest_id"],
        price: json["price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sizePrice: json["size_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "preparation_time": preparationTime,
        "item_id": itemId,
        "item_size_price_id": itemSizePriceId,
        "table_id": tableId,
        "order_id": orderId,
        "user_id": userId,
        "rest_id": restId,
        "price": price,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "size_price": sizePrice,
      };
}
