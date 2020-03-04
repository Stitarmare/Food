// To parse this JSON data, do
//
//     final currentOrderDetailsModel = currentOrderDetailsModelFromJson(jsonString);

import 'dart:convert';

CurrentOrderDetailsModel currentOrderDetailsModelFromJson(String str) =>
    CurrentOrderDetailsModel.fromJson(json.decode(str));

String currentOrderDetailsModelToJson(CurrentOrderDetailsModel data) =>
    json.encode(data.toJson());

class CurrentOrderDetailsModel {
  String status;
  int statusCode;
  List<CurrentOrderList> data;

  CurrentOrderDetailsModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory CurrentOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      CurrentOrderDetailsModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<CurrentOrderList>.from(
            json["data"].map((x) => CurrentOrderList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CurrentOrderList {
  int id;
  String orderType;
  int tableId;
  int userId;
  dynamic additionalComments;
  int restId;
  String orderNumber;
  String status;
  String totalAmount;
  DateTime createdAt;
  DateTime updatedAt;
  Restaurant restaurant;
  List<ListElement> list;

  CurrentOrderList({
    this.id,
    this.orderType,
    this.tableId,
    this.userId,
    this.additionalComments,
    this.restId,
    this.orderNumber,
    this.status,
    this.totalAmount,
    this.createdAt,
    this.updatedAt,
    this.restaurant,
    this.list,
  });

  factory CurrentOrderList.fromJson(Map<String, dynamic> json) =>
      CurrentOrderList(
        id: json["id"],
        orderType: json["order_type"],
        tableId: json["table_id"],
        userId: json["user_id"],
        additionalComments: json["additional_comments"],
        restId: json["rest_id"],
        orderNumber: json["order_number"],
        status: json["status"],
        totalAmount: json["total_amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        restaurant: Restaurant.fromJson(json["restaurant"]),
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_type": orderType,
        "table_id": tableId,
        "user_id": userId,
        "additional_comments": additionalComments,
        "rest_id": restId,
        "order_number": orderNumber,
        "status": status,
        "total_amount": totalAmount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "restaurant": restaurant.toJson(),
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  int id;
  int quantity;
  String preparationTime;
  int itemId;
  dynamic itemSizePriceId;
  int tableId;
  int orderId;
  int userId;
  int restId;
  String price;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic sizePrice;
  Items items;

  ListElement({
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
    this.items,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        quantity: json["quantity"],
        preparationTime: json["preparation_time"],
        itemId: json["item_id"],
        itemSizePriceId: json["item_size_price_id"],
        tableId: json["table_id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        restId: json["rest_id"],
        price: json["price"] == null ? null : json["price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sizePrice: json["size_price"],
        items: Items.fromJson(json["items"]),
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
        "price": price == null ? null : price,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "size_price": sizePrice,
        "items": items.toJson(),
      };
}

class Items {
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

  Items({
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

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        id: json["id"],
        itemName: json["item_name"],
        price: json["price"],
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
        "price": price,
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

class Restaurant {
  int id;
  String restName;
  String addressLine1;
  String addressLine2;
  String addressLine3;

  Restaurant({
    this.id,
    this.restName,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        restName: json["rest_name"],
        addressLine1: json["address_line_1"],
        addressLine2:
            json["address_line_2"] == null ? null : json["address_line_2"],
        addressLine3: json["address_line_3"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rest_name": restName,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2 == null ? null : addressLine2,
        "address_line_3": addressLine3,
      };
}
