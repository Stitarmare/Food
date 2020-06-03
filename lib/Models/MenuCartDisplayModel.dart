import 'dart:convert';

import 'package:foodzi/Models/AddMenuToCartModel.dart';

MenuCartDisplayModel menuCartDisplayModelFromJson(String str) =>
    MenuCartDisplayModel.fromJson(json.decode(str));

String menuCartDisplayModelToJson(MenuCartDisplayModel data) =>
    json.encode(data.toJson());

class MenuCartDisplayModel {
  String status;
  int statusCode;
  List<MenuCartList> data;
  int cartCount;
  String grandTotal;
  String colourCode;
  String currencySymbol;

  MenuCartDisplayModel({
    this.status,
    this.statusCode,
    this.data,
    this.cartCount,
    this.grandTotal,
    this.colourCode,
    this.currencySymbol,
  });

  factory MenuCartDisplayModel.fromJson(Map<String, dynamic> json) =>
      MenuCartDisplayModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<MenuCartList>.from(
            json["data"].map((x) => MenuCartList.fromJson(x))),
        cartCount: json["cartCount"],
        grandTotal: json["grandTotal"],
        colourCode: json["colour_code"],
        currencySymbol: json["currency_symbol"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "cartCount": cartCount,
        "grandTotal": grandTotal,
        "colour_code": colourCode,
        "currency_symbol": currencySymbol,
      };
}

class MenuCartList {
  int id;
  int quantity;
  String preparationTime;
  int itemId;
  dynamic itemSizePriceId;
  int tableId;
  String price;
  int userId;
  int restId;
  String createdAt;
  String updatedAt;
  dynamic sizePrice;
  String totalAmount;
  Item items;
  // List<dynamic> cartExtraItems;
  List<CartExtraItem> cartExtraItems;

  MenuCartList({
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
    this.sizePrice,
    this.totalAmount,
    this.items,
    this.cartExtraItems,
  });

  MenuCartList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    preparationTime = json['preparation_time'];
    itemId = json['item_id'];
    itemSizePriceId = json['item_size_price_id'];
    tableId = json['table_id'];
    price = json['price'];
    userId = json['user_id'];
    restId = json['rest_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sizePrice = json['size_price'];
    totalAmount = json['totalAmount'];
    items = json['items'] != null ? new Item.fromJson(json['items']) : null;
    if (json['cart_extra_items'] != null) {
      cartExtraItems = new List<CartExtraItem>();
      json['cart_extra_items'].forEach((v) {
        cartExtraItems.add(new CartExtraItem.fromJson(v));
      });
    }
  }

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
        "created_at": createdAt,
        "updated_at": updatedAt,
        "size_price": sizePrice,
        "totalAmount": totalAmount,
        "items": items.toJson(),
        "cart_extra_items": List<dynamic>.from(cartExtraItems.map((x) => x)),
      };
}

class Item {
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

  Item({
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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

class CartExtraItem {
  int id;
  int cartId;
  int itemId;
  int extraId;
  int spreadId;
  int switchId;
  dynamic orderListId;
  DateTime createdAt;
  DateTime updatedAt;
  String switchOption;
  String price;
  List<Extra> extras;
  List<Extra> spreads;
  List<Extra> switches;
  List<Subspreads> subspreads;

  CartExtraItem(
      {this.id,
      this.cartId,
      this.itemId,
      this.extraId,
      this.spreadId,
      this.switchId,
      this.orderListId,
      this.createdAt,
      this.updatedAt,
      this.switchOption,
      this.price,
      this.extras,
      this.spreads,
      this.switches,
      this.subspreads});

  factory CartExtraItem.fromJson(Map<String, dynamic> json) => CartExtraItem(
        id: json["id"],
        cartId: json["cart_id"],
        itemId: json["item_id"],
        extraId: json["extra_id"] == null ? null : json["extra_id"],
        spreadId: json["spread_id"] == null ? null : json["spread_id"],
        switchId: json["switch_id"] == null ? null : json["switch_id"],
        orderListId: json["order_list_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        switchOption:
            json["switch_option"] == null ? null : json["switch_option"],
        price: json["price"] == null ? null : json["price"],
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
        spreads:
            List<Extra>.from(json["spreads"].map((x) => Extra.fromJson(x))),
        switches:
            List<Extra>.from(json["switches"].map((x) => Extra.fromJson(x))),
        subspreads: json["subspreads"] != null
            ? List<Subspreads>.from(
                json["subspreads"].map((x) => Subspreads.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "item_id": itemId,
        "extra_id": extraId == null ? null : extraId,
        "spread_id": spreadId == null ? null : spreadId,
        "switch_id": switchId == null ? null : switchId,
        "order_list_id": orderListId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "switch_option": switchOption == null ? null : switchOption,
        "price": price == null ? null : price,
        "extras": List<dynamic>.from(extras.map((x) => x.toJson())),
        "spreads": List<dynamic>.from(spreads.map((x) => x.toJson())),
        "switches": List<dynamic>.from(switches.map((x) => x.toJson())),
      };
}

class Extra {
  int id;
  String name;
  String price;
  int restId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String option1;
  String option2;

  Extra({
    this.id,
    this.name,
    this.price,
    this.restId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.option1,
    this.option2,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        name: json["name"],
        price: json["price"] == null ? null : json["price"],
        restId: json["rest_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        option1: json["option1"] == null ? null : json["option1"],
        option2: json["option2"] == null ? null : json["option2"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price == null ? null : price,
        "rest_id": restId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "option1": option1 == null ? null : option1,
        "option2": option2 == null ? null : option2,
      };
}

class Subspreads {
  int id;
  String name;

  Subspreads({
    this.id,
    this.name,
  });

  factory Subspreads.fromJson(Map<String, dynamic> json) => Subspreads(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
