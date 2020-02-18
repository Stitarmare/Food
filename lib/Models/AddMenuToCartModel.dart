// To parse this JSON data, do
//
//     final addMenuToCartModel = addMenuToCartModelFromJson(jsonString);

import 'dart:convert';

AddMenuToCartModel addMenuToCartModelFromJson(String str) =>
    AddMenuToCartModel.fromJson(json.decode(str));

String addMenuToCartModelToJson(AddMenuToCartModel data) =>
    json.encode(data.toJson());

class AddMenuToCartModel {
  String status;
  int statusCode;
  String message;
  List<AddMenuToCartList> data;
  int totalAmount;
  String colourCode;

  AddMenuToCartModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.totalAmount,
    this.colourCode,
  });

  factory AddMenuToCartModel.fromJson(Map<String, dynamic> json) =>
      AddMenuToCartModel(
        status: json["status"],
        statusCode: json["status_code"],
        message: json["message"],
        data: List<AddMenuToCartList>.from(
            json["data"].map((x) => AddMenuToCartList.fromJson(x))),
        totalAmount: json["totalAmount"],
        colourCode: json["colour_code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totalAmount": totalAmount,
        "colour_code": colourCode,
      };
}

class AddMenuToCartList {
  int id;
  int quantity;
  String preparationTime;
  int itemId;
  dynamic itemSizePriceId;
  int tableId;
  String price;
  int userId;
  int restId;
  DateTime createdAt;
  DateTime updatedAt;

  AddMenuToCartList({
    this.id,
    this.quantity,
    this.preparationTime,
    this.itemId,
    this.itemSizePriceId,
    this.tableId,
    this.price,
    this.userId,
    this.restId,
    this.createdAt,
    this.updatedAt,
  });

  factory AddMenuToCartList.fromJson(Map<String, dynamic> json) =>
      AddMenuToCartList(
        id: json["id"],
        quantity: json["quantity"],
        preparationTime: json["preparation_time"],
        itemId: json["item_id"],
        itemSizePriceId: json["item_size_price_id"],
        tableId: json["table_id"],
        price: json["price"],
        userId: json["user_id"],
        restId: json["rest_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "preparation_time": preparationTime,
        "item_id": itemId,
        "item_size_price_id": itemSizePriceId,
        "table_id": tableId,
        "price": price,
        "user_id": userId,
        "rest_id": restId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
