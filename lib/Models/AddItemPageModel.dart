import 'dart:convert';

AddItemPageModelList addItemPageModelListFromJson(String str) =>
    AddItemPageModelList.fromJson(json.decode(str));

String addItemPageModelListToJson(AddItemPageModelList data) =>
    json.encode(data.toJson());

class AddItemPageModelList {
  String status;
  int statusCode;
  List<AddItemModelList> data;
  String colourCode;
  String currencySymbol;
  String extrasLabel;
  String spreadsLabel;
  String switchesLabel;

  AddItemPageModelList({
    this.status,
    this.statusCode,
    this.data,
    this.colourCode,
    this.currencySymbol,
    this.extrasLabel,
    this.spreadsLabel,
    this.switchesLabel,
  });

  factory AddItemPageModelList.fromJson(Map<String, dynamic> json) =>
      AddItemPageModelList(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<AddItemModelList>.from(
            json["data"].map((x) => AddItemModelList.fromJson(x))),
        colourCode: json["colour_code"],
        currencySymbol: json["currency_symbol"],
        extrasLabel: json["extras_label"],
        spreadsLabel: json["spreads_label"],
        switchesLabel: json["switches_label"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "colour_code": colourCode,
        "currency_symbol": currencySymbol,
        "extras_label": extrasLabel,
        "spreads_label": spreadsLabel,
        "switches_label": switchesLabel,
      };
}

class AddItemModelList {
  int id;
  String itemName;
  String price;
  String itemDescription;
  String menuType;
  String extrasrequired;
  String spreadsrequired;
  String switchesrequired;
  String extrasLabel;
  String spreadsLabel;
  String switchesLabel;
  String defaultPreparationTime;
  String itemCode;
  String itemImage;
  int workstationId;
  DateTime createdAt;
  DateTime updatedAt;
  int restId;
  List<Extra> extras;
  List<Spread> spreads;
  List<Switch> switches;
  List<SizePrize> sizePrizes;

  AddItemModelList({
    this.id,
    this.itemName,
    this.price,
    this.itemDescription,
    this.menuType,
    this.extrasrequired,
    this.spreadsrequired,
    this.switchesrequired,
    this.extrasLabel,
    this.spreadsLabel,
    this.switchesLabel,
    this.defaultPreparationTime,
    this.itemCode,
    this.itemImage,
    this.workstationId,
    this.createdAt,
    this.updatedAt,
    this.restId,
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
        menuType: json["menu_type"],
        extrasrequired: json["extrasrequired"],
        spreadsrequired: json["spreadsrequired"],
        switchesrequired: json["switchesrequired"],
        extrasLabel: json["extras_label"],
        spreadsLabel: json["spreads_label"],
        switchesLabel: json["switches_label"],
        defaultPreparationTime: json["default_preparation_time"],
        itemCode: json["item_code"],
        itemImage: json["item_image"],
        workstationId: json["workstation_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        restId: json["rest_id"],
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
        spreads:
            List<Spread>.from(json["spreads"].map((x) => Spread.fromJson(x))),
        switches:
            List<Switch>.from(json["switches"].map((x) => Switch.fromJson(x))),
        sizePrizes: List<SizePrize>.from(
            json["size_prizes"].map((x) => SizePrize.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "price": price,
        "item_description": itemDescription,
        "menu_type": menuType,
        "extrasrequired": extrasrequired,
        "spreadsrequired": spreadsrequired,
        "switchesrequired": switchesrequired,
        "extras_label": extrasLabel,
        "spreads_label": spreadsLabel,
        "switches_label": switchesLabel,
        "default_preparation_time": defaultPreparationTime,
        "item_code": itemCode,
        "item_image": itemImage,
        "workstation_id": workstationId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rest_id": restId,
        "extras": List<dynamic>.from(extras.map((x) => x.toJson())),
        "spreads": List<dynamic>.from(spreads.map((x) => x.toJson())),
        "switches": List<dynamic>.from(switches.map((x) => x.toJson())),
        "size_prizes": List<dynamic>.from(sizePrizes.map((x) => x.toJson())),
      };
}

class Extra {
  int id;
  String name;
  String price;
  DateTime createdAt;
  DateTime updatedAt;
  String extraDefault;

  Extra({
    this.id,
    this.name,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.extraDefault,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        extraDefault: json["default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "default": extraDefault,
      };
}

class SizePrize {
  int id;
  int itemId;
  String price;
  String size;
  String status;

  SizePrize({
    this.id,
    this.itemId,
    this.price,
    this.size,
    this.status,
  });

  factory SizePrize.fromJson(Map<String, dynamic> json) => SizePrize(
        id: json["id"],
        itemId: json["item_id"],
        price: json["price"],
        size: json["size"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "price": price,
        "size": size,
        "status": status,
      };
}

class Spread {
  int id;
  String name;
  String price;
  int restId;
  String status;
  String spreadDefault;

  Spread(
      {this.id,
      this.name,
      this.price,
      this.restId,
      this.status,
      this.spreadDefault});

  factory Spread.fromJson(Map<String, dynamic> json) => Spread(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        restId: json["rest_id"],
        status: json["status"],
        spreadDefault: json["default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "rest_id": restId,
        "status": status,
        "default": spreadDefault
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

  String switchDefault;

  Switch({
    this.id,
    this.name,
    this.option1,
    this.option2,
    this.status,
    this.restId,
    this.createdAt,
    this.updatedAt,
    this.switchDefault,
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
        switchDefault: json["default"],
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
        "default": switchDefault,
      };
}
