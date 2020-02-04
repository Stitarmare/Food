import 'dart:convert';

// RestaurantItemsModel restaurantItemsModelFromJson(String str) =>
//     RestaurantItemsModel.fromJson(json.decode(str));

// String restaurantItemsModelToJson(RestaurantItemsModel data) =>
//     json.encode(data.toJson());

class RestaurantItemsModel {
  String status;
  int statusCode;
  int page;
  int totalPages;
  List<RestaurantMenuItem> data;

  RestaurantItemsModel({
    this.status,
    this.statusCode,
    this.page,
    this.totalPages,
    this.data,
  });

  factory RestaurantItemsModel.fromJson(Map<String, dynamic> json) =>
      RestaurantItemsModel(
        status: json["status"],
        statusCode: json["status_code"],
        page: json["page"],
        totalPages: json["totalPages"],
        data: List<RestaurantMenuItem>.from(
            json["data"].map((x) => RestaurantMenuItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "page": page,
        "totalPages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RestaurantMenuItem {
  int id;
  String itemName;
  String itemDescription;
  int workstationId;
  int restId;
  String menuType;
  String defaultPreparationTime;
  String itemCode;
  String status;
  String itemImage;
  DateTime createdAt;
  DateTime updatedAt;
  String price;
  dynamic category;
  dynamic sizePrize;

  RestaurantMenuItem({
    this.id,
    this.itemName,
    this.itemDescription,
    this.workstationId,
    this.restId,
    this.menuType,
    this.defaultPreparationTime,
    this.itemCode,
    this.status,
    this.itemImage,
    this.createdAt,
    this.updatedAt,
    this.price,
    this.category,
    this.sizePrize,
  });

  factory RestaurantMenuItem.fromJson(Map<String, dynamic> json) =>
      RestaurantMenuItem(
        id: json["id"],
        itemName: json["item_name"],
        itemDescription: json["item_description"],
        workstationId: json["workstation_id"],
        restId: json["rest_id"],
        menuType: json["menu_type"],
        defaultPreparationTime: json["default_preparation_time"],
        itemCode: json["item_code"],
        status: json["status"],
        itemImage: json["item_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        price: json["price"],
        category: json["category"],
        sizePrize: json["size_prize"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "item_description": itemDescription,
        "workstation_id": workstationId,
        "rest_id": restId,
        "menu_type": menuType,
        "default_preparation_time": defaultPreparationTime,
        "item_code": itemCode,
        "status": status,
        "item_image": itemImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "price": price,
        "category": category,
        "size_prize": sizePrize,
      };
}
