// To parse this JSON data, do
//
//     final addItemPageModelList = addItemPageModelListFromJson(jsonString);

import 'dart:convert';

AddItemPageModelList addItemPageModelListFromJson(String str) =>
    AddItemPageModelList.fromJson(json.decode(str));

String addItemPageModelListToJson(AddItemPageModelList data) =>
    json.encode(data.toJson());

class AddItemPageModelList {
  String status;
  int statusCode;
  String currencySymbol;
  List<AddItemModelList> data;

  AddItemPageModelList({
    this.status,
    this.statusCode,
    this.data,
    this.currencySymbol,
  });

  factory AddItemPageModelList.fromJson(Map<String, dynamic> json) =>
      AddItemPageModelList(
        status: json["status"],
        statusCode: json["status_code"],
        currencySymbol: json["currency_symbol"],
        data: List<AddItemModelList>.from(
            json["data"].map((x) => AddItemModelList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "currency_symbol": currencySymbol,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AddItemModelList {
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
  List<Extra> extras;
  List<Spread> spreads;
  List<Switch> switches;
  List<dynamic> sizePrizes;

  AddItemModelList({
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
    this.extras,
    this.spreads,
    this.switches,
    this.sizePrizes,
  });

  factory AddItemModelList.fromJson(Map<String, dynamic> json) =>
      AddItemModelList(
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
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
        spreads:
            List<Spread>.from(json["spreads"].map((x) => Spread.fromJson(x))),
        switches:
            List<Switch>.from(json["switches"].map((x) => Switch.fromJson(x))),
        sizePrizes: List<dynamic>.from(json["size_prizes"].map((x) => x)),
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
        "extras": List<dynamic>.from(extras.map((x) => x.toJson())),
        "spreads": List<dynamic>.from(spreads.map((x) => x.toJson())),
        "switches": List<dynamic>.from(switches.map((x) => x.toJson())),
        "size_prizes": List<dynamic>.from(sizePrizes.map((x) => x)),
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
  ExtraPivot pivot;

  Extra({
    this.id,
    this.name,
    this.price,
    this.restId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        restId: json["rest_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: ExtraPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "rest_id": restId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class ExtraPivot {
  int itemId;
  int extraId;

  ExtraPivot({
    this.itemId,
    this.extraId,
  });

  factory ExtraPivot.fromJson(Map<String, dynamic> json) => ExtraPivot(
        itemId: json["item_id"],
        extraId: json["extra_id"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "extra_id": extraId,
      };
}

class Spread {
  int id;
  String name;
  String price;
  int restId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  SpreadPivot pivot;

  Spread({
    this.id,
    this.name,
    this.price,
    this.restId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Spread.fromJson(Map<String, dynamic> json) => Spread(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        restId: json["rest_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: SpreadPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "rest_id": restId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class SpreadPivot {
  int itemId;
  int spreadId;

  SpreadPivot({
    this.itemId,
    this.spreadId,
  });

  factory SpreadPivot.fromJson(Map<String, dynamic> json) => SpreadPivot(
        itemId: json["item_id"],
        spreadId: json["spread_id"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "spread_id": spreadId,
      };
}

class Switch {
  int id;
  String name;
  String option1;
  String option2;
  String status;
  int restId;
  DateTime createdAt;
  DateTime updatedAt;
  SwitchPivot pivot;

  Switch({
    this.id,
    this.name,
    this.option1,
    this.option2,
    this.status,
    this.restId,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Switch.fromJson(Map<String, dynamic> json) => Switch(
        id: json["id"],
        name: json["name"],
        option1: json["option1"],
        option2: json["option2"],
        status: json["status"],
        restId: json["rest_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: SwitchPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "option1": option1,
        "option2": option2,
        "status": status,
        "rest_id": restId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class SwitchPivot {
  int itemId;
  int switchId;

  SwitchPivot({
    this.itemId,
    this.switchId,
  });

  factory SwitchPivot.fromJson(Map<String, dynamic> json) => SwitchPivot(
        itemId: json["item_id"],
        switchId: json["switch_id"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "switch_id": switchId,
      };
}
