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

// To parse this JSON data, do
//
//     final addItemsToCartModel = addItemsToCartModelFromJson(jsonString);

// AddItemsToCartModel addItemsToCartModelFromJson(String str) => AddItemsToCartModel.fromJson(json.decode(str));

// String addItemsToCartModelToJson(AddItemsToCartModel data) => json.encode(data.toJson());

class AddItemsToCartModel {
  int userId;
  int restId;
  int tableId;
  List<Item> items;

  AddItemsToCartModel({
    this.userId,
    this.restId,
    this.tableId,
    this.items,
  });

  factory AddItemsToCartModel.fromJson(Map<String, dynamic> json) =>
      AddItemsToCartModel(
        userId: json["user_id"],
        restId: json["rest_id"],
        tableId: json["table_id"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "rest_id": restId,
        "table_id": tableId,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  int itemId;
  int quantity;
  int sizePriceId;
  List<Extras> extra;
  List<Spreads> spreads;
  List<Switch> switches;

  Item({
    this.itemId,
    this.quantity,
    this.sizePriceId,
    this.extra,
    this.spreads,
    this.switches,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["item_id"],
        quantity: json["quantity"],
        sizePriceId: json["size_price_id"],
        extra: List<Extras>.from(json["extra"].map((x) => Extras.fromJson(x))),
        spreads:
            List<Spreads>.from(json["spreads"].map((x) => Spreads.fromJson(x))),
        switches:
            List<Switch>.from(json["switches"].map((x) => Switch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "quantity": quantity,
        "size_price_id": sizePriceId,
        "extra": List<dynamic>.from(extra.map((x) => x.toJson())),
        "spreads": List<dynamic>.from(spreads.map((x) => x.toJson())),
        "switches": List<dynamic>.from(switches.map((x) => x.toJson())),
      };
}

class Extras {
  int extraId;

  Extras({
    this.extraId,
  });

  factory Extras.fromJson(Map<String, dynamic> json) => Extras(
        extraId: json["extra_id"],
      );

  Map<String, dynamic> toJson() => {
        "extra_id": extraId,
      };
}

class Spreads {
  int spreadId;

  Spreads({
    this.spreadId,
  });

  factory Spreads.fromJson(Map<String, dynamic> json) => Spreads(
        spreadId: json["spread_id"],
      );

  Map<String, dynamic> toJson() => {
        "spread_id": spreadId,
      };
}

class Switch {
  int switchId;
  String switchOption;

  Switch({
    this.switchId,
    this.switchOption,
  });

  factory Switch.fromJson(Map<String, dynamic> json) => Switch(
        switchId: json["switch_id"],
        switchOption: json["switch_option"],
      );

  Map<String, dynamic> toJson() => {
        "switch_id": switchId,
        "switch_option": switchOption,
      };
}
